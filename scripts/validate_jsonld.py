#!/usr/bin/env python3
"""
JSON-LD Schema Validator for LM Knowledge Fabric

Usage:
    python scripts/validate_jsonld.py 00_System_Config/LM_NOTEBOOKS.jsonld

Returns:
    Exit code 0 if valid, 1 if invalid
"""

import json
import sys
from pathlib import Path

def validate_jsonld(filepath):
    """Validate JSON-LD file against basic schema requirements."""
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except FileNotFoundError:
        print(f"❌ File not found: {filepath}")
        return False
    except json.JSONDecodeError as e:
        print(f"❌ Invalid JSON: {e}")
        return False
    
    # Check required top-level keys
    required_keys = ['@context', '@graph']
    for key in required_keys:
        if key not in data:
            print(f"❌ Missing required key: {key}")
            return False
    
    # Validate @context
    if not isinstance(data['@context'], dict):
        print("❌ @context must be an object")
        return False
    
    # Validate @graph
    if not isinstance(data['@graph'], list):
        print("❌ @graph must be an array")
        return False
    
    # Validate each node in graph
    for i, node in enumerate(data['@graph']):
        if 'id' not in node:
            print(f"❌ Node {i} missing 'id' field")
            return False
        
        if 'type' not in node:
            print(f"❌ Node {i} missing 'type' field")
            return False
        
        # Check ID format (should have prefix:type)
        if ':' not in node['id']:
            print(f"⚠️  Node {i} ID '{node['id']}' doesn't follow prefix:type convention")
    
    print(f"✅ Valid JSON-LD: {len(data['@graph'])} nodes")
    return True

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python validate_jsonld.py <path-to-jsonld-file>")
        sys.exit(1)
    
    filepath = sys.argv[1]
    is_valid = validate_jsonld(filepath)
    sys.exit(0 if is_valid else 1)
