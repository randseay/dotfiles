#!/usr/bin/env python3
# coding=UTF-8

import math
import subprocess
import sys
import platform
import os

def extract_float(line):
    value = line.rpartition(b'=')[-1].strip()
    # Remove trailing non-digit characters (e.g., '}')
    value = value.rstrip(b'}')
    return float(value)

def extract_int(line):
    value = line.rpartition(b'=')[-1].strip()
    value = value.rstrip(b'}')
    return int(value)

def extract_str(line):
    return line.rpartition(b'=')[-1].strip()

def get_macos_battery():
    """Get battery information on macOS using ioreg"""
    try:
        p = subprocess.Popen(["ioreg", "-rc", "AppleSmartBattery"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output, error = p.communicate()
        
        if p.returncode != 0 or not output:
            return None
            
        # Pull out pertinent key-value pairs
        lines = output.splitlines()
        
        o_max = [l for l in lines if b'MaxCapacity' in l]
        o_cur = [l for l in lines if b'CurrentCapacity' in l]
        o_charge = [l for l in lines if b'IsCharging' in l]
        o_charged = [l for l in lines if b'FullyCharged' in l]
        o_time_remaining = [l for l in lines if b'TimeRemaining' in l]
        
        if not all([o_max, o_cur, o_charge, o_charged, o_time_remaining]):
            return None
            
        # Strip out the value in each key-value pair
        b_max = extract_float(o_max[0])
        b_cur = extract_float(o_cur[0])
        b_charge = extract_str(o_charge[0])
        b_charged = extract_str(o_charged[0])
        b_time_remaining = extract_int(o_time_remaining[0])
        
        return {
            'max': b_max,
            'current': b_cur,
            'charging': b_charge == b'Yes',
            'fully_charged': b_charged == b'Yes',
            'time_remaining': b_time_remaining
        }
    except (subprocess.SubprocessError, FileNotFoundError, IndexError, ValueError):
        return None

def get_linux_battery():
    """Get battery information on Linux using /sys/class/power_supply"""
    try:
        # Look for battery directories
        battery_dirs = []
        power_supply_path = "/sys/class/power_supply"
        
        if not os.path.exists(power_supply_path):
            return None
            
        for item in os.listdir(power_supply_path):
            if item.startswith("BAT"):
                battery_dirs.append(item)
        
        if not battery_dirs:
            return None
            
        # Use the first battery found
        battery_path = os.path.join(power_supply_path, battery_dirs[0])
        
        # Read battery information
        with open(os.path.join(battery_path, "capacity"), "r") as f:
            capacity = int(f.read().strip())
            
        with open(os.path.join(battery_path, "status"), "r") as f:
            status = f.read().strip()
            
        # Check if charging
        charging = status in ["Charging", "Full"]
        fully_charged = status == "Full"
        
        # Try to get time remaining (this might not be available on all systems)
        time_remaining = 0
        try:
            with open(os.path.join(battery_path, "time_to_empty_now"), "r") as f:
                time_remaining = int(f.read().strip())
        except (FileNotFoundError, ValueError):
            pass
            
        return {
            'max': 100.0,
            'current': float(capacity),
            'charging': charging,
            'fully_charged': fully_charged,
            'time_remaining': time_remaining
        }
    except (OSError, IOError, ValueError):
        return None

def get_windows_battery():
    """Get battery information on Windows using wmic"""
    try:
        p = subprocess.Popen(["wmic", "path", "Win32_Battery", "get", "EstimatedChargeRemaining,Status,TimeToEmpty", "/format:csv"], 
                           stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output, error = p.communicate()
        
        if p.returncode != 0 or not output:
            return None
            
        lines = output.decode('utf-8').splitlines()
        if len(lines) < 2:
            return None
            
        # Parse CSV output
        parts = lines[1].split(',')
        if len(parts) < 3:
            return None
            
        capacity = float(parts[1])
        status = parts[2]
        time_remaining = int(parts[3]) if parts[3].isdigit() else 0
        
        charging = status in ["Charging", "Full"]
        fully_charged = status == "Full"
        
        return {
            'max': 100.0,
            'current': capacity,
            'charging': charging,
            'fully_charged': fully_charged,
            'time_remaining': time_remaining
        }
    except (subprocess.SubprocessError, FileNotFoundError, IndexError, ValueError):
        return None

def format_battery_output(battery_info):
    """Format battery information for display"""
    if not battery_info:
        return " [no-battery]"
    
    divisor = 6
    charge = battery_info['current'] / battery_info['max']
    charge_threshold = int(math.ceil(divisor * charge))
    
    # Format time remaining
    if battery_info['time_remaining'] > 0 and not battery_info['fully_charged']:
        hours = battery_info['time_remaining'] // 60
        minutes = battery_info['time_remaining'] % 60
        time_remaining = f" [{hours}:{minutes:02d}]"
    else:
        time_remaining = ""
    
    # Create battery visual
    total_slots = divisor
    filled = "▸" * charge_threshold
    empty = "▹" * (total_slots - charge_threshold)
    
    battery_out = " " + filled + empty
    
    # Determine what to show
    if battery_info['fully_charged']:
        battery_or_charge = " Full"
    elif battery_info['charging']:
        battery_or_charge = ""
    else:
        battery_or_charge = battery_out
    
    # Charging indicator
    charging_out = " ⚡︎" if battery_info['charging'] else ""
    
    # Color coding
    if charge > 2/3:
        color = "%{$FG[034]%}"  # Green
    elif charge > 1/3:
        color = "%{$FG[184]%}"  # Yellow
    else:
        color = "%{$FG[160]%}"  # Red
    
    color_gold = "%{$FG[214]%}"
    color_reset = "%{$FG[240]%}"
    
    return f"{color}{battery_or_charge}{color_gold}{charging_out}{color_reset}{time_remaining}"

def main():
    """Main function to get battery information based on platform"""
    system = platform.system()
    
    battery_info = None
    
    if system == "Darwin":  # macOS
        battery_info = get_macos_battery()
    elif system == "Linux":
        battery_info = get_linux_battery()
    elif system == "Windows":
        battery_info = get_windows_battery()
    
    # Output formatted battery information
    output = format_battery_output(battery_info)
    sys.stdout.write(output)

if __name__ == "__main__":
    main()
