#!/usr/bin/env python3

"""
Skill Initializer - Initializes a new skill directory with templates

Usage:
    python scripts/init_skill.py <skill-name> --path <output-directory>

Example:
    python scripts/init_skill.py my-skill --path ./skills
"""

import sys
import os
import argparse
from pathlib import Path

def create_skill(name, output_dir):
    """
    Creates a new skill directory with standard structure and templates.
    """
    base_path = Path(output_dir) / name
    
    # Create directory structure
    dirs = [
        base_path,
        base_path / "scripts",
        base_path / "references",
        base_path / "assets"
    ]
    
    for d in dirs:
        d.mkdir(parents=True, exist_ok=True)
        print(f"Created: {d}")

    # Create SKILL.md template
    skill_md_content = f"""---
name: {name}
description: [TODO: Add a clear description of when to use this skill and what it does]
---

# {name.replace('-', ' ').title()}

[TODO: Add a high-level overview of the skill here]

## Instructions

[TODO: Add detailed instructions on how to use the skill]

## Resources

- **Scripts**: See `scripts/` directory
- **References**: See `references/` directory
"""
    
    with open(base_path / "SKILL.md", "w") as f:
        f.write(skill_md_content)
    print(f"Created: {base_path / 'SKILL.md'}")

    # Create example files
    with open(base_path / "scripts/example.py", "w") as f:
        f.write("# Example script\nprint('Hello from the skill!')\n")
    
    with open(base_path / "references/example.md", "w") as f:
        f.write("# Example Reference\n\nThis is an example reference file.\n")

    print(f"\n✅ Successfully initialized skill '{name}' at {base_path}")

def main():
    parser = argparse.ArgumentParser(description="Initialize a new agent skill")
    parser.add_argument("name", help="Name of the skill")
    parser.add_argument("--path", default=".", help="Directory to create the skill in")
    
    args = parser.parse_args()
    
    create_skill(args.name, args.path)

if __name__ == "__main__":
    main()
