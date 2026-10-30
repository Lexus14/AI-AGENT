#!/usr/bin/env python3
"""
Rogue Galaxy Translation Validator
Checks translated lines against original lines to prevent crashes caused by:
- Missing format specifiers (%s, %d, %i, %f, etc.)
- Mismatched control tags (e.g. <COLOR:XX>)
- Excessive line lengths that may cause overflow on PS2 screens
"""

import re
import sys
from typing import List, Dict, Any

FORMAT_SPECIFIER_REGEX = re.compile(r'%[0-9]*\.?[0-9]*[sdifxX%]')
TAG_REGEX = re.compile(r'<[^>]+>')

def extract_format_specifiers(text: str) -> List[str]:
    return FORMAT_SPECIFIER_REGEX.findall(text)

def extract_tags(text: str) -> List[str]:
    return TAG_REGEX.findall(text)

def validate_line(original: str, translated: str, max_length: int = 60) -> List[str]:
    errors = []

    # 1. Check format specifiers
    orig_specs = extract_format_specifiers(original)
    trans_specs = extract_format_specifiers(translated)

    if sorted(orig_specs) != sorted(trans_specs):
        errors.append(
            f"Format specifier mismatch! Original: {orig_specs}, Translated: {trans_specs}"
        )

    # 2. Check tags
    orig_tags = extract_tags(original)
    trans_tags = extract_tags(translated)

    if len(orig_tags) != len(trans_tags):
        errors.append(
            f"Tag count mismatch! Original tags: {orig_tags}, Translated tags: {trans_tags}"
        )

    # 3. Check line length warning
    # Split by explicit line breaks if any
    lines = translated.split(r'\n')
    for line in lines:
        clean_line = TAG_REGEX.sub('', line)
        if len(clean_line) > max_length:
            errors.append(
                f"Line length warning ({len(clean_line)} chars > {max_length}): '{clean_line}'"
            )

    return errors

def validate_translation_pairs(pairs: List[Dict[str, str]], max_length: int = 60) -> List[Dict[str, Any]]:
    results = []
    for idx, pair in enumerate(pairs):
        orig = pair.get('original', '')
        trans = pair.get('translated', '')
        errs = validate_line(orig, trans, max_length=max_length)
        if errs:
            results.append({
                'index': idx,
                'original': orig,
                'translated': trans,
                'errors': errs
            })
    return results

if __name__ == '__main__':
    print("Rogue Galaxy Translation Validator loaded successfully.")
