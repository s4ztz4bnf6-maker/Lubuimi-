# SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import unittest
from adapters import static_extract, article_extract
class ExtractionTests(unittest.TestCase):
    def test_static(self):
        self.assertEqual(static_extract("<nav>menu</nav><main>Hello</main><script>bad()</script>"), "Hello")
    def test_limit(self):
        self.assertLessEqual(len(static_extract("<p>"+"x"*20000+"</p>")),15000)
if __name__ == "__main__":
    unittest.main()
