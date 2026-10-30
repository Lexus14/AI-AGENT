#!/usr/bin/env python3
import unittest
from tools.validate_translation import validate_line, validate_translation_pairs

class TestTranslationValidator(unittest.TestCase):
    def test_matching_specifiers_and_tags(self):
        orig = "You obtained %s x%d! <COLOR:01>Nice!</COLOR>"
        trans = "Kamu mendapatkan %s x%d! <COLOR:01>Bagus!</COLOR>"
        errs = validate_line(orig, trans)
        self.assertEqual(len(errs), 0)

    def test_missing_specifier(self):
        orig = "You obtained %s x%d!"
        trans = "Kamu mendapatkan item ini!"
        errs = validate_line(orig, trans)
        self.assertTrue(any("Format specifier mismatch" in e for e in errs))

    def test_mismatched_tags(self):
        orig = "<COLOR:01>Hello</COLOR>"
        trans = "<COLOR:01>Halo"
        errs = validate_line(orig, trans)
        self.assertTrue(any("Tag count mismatch" in e for e in errs))

    def test_excessive_length(self):
        orig = "Short line"
        trans = "Ini adalah kalimat yang sangat amat panjang sekali melebihi batas karakter normal layar game PS2"
        errs = validate_line(orig, trans, max_length=50)
        self.assertTrue(any("Line length warning" in e for e in errs))

if __name__ == '__main__':
    unittest.main()
