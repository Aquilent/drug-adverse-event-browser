# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class S2VerifyGlobalNavigationPython(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://gsa-ads-2-elbwebex-1l78v7v6k7szj-2091903140.us-east-1.elb.amazonaws.com/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_s2_verify_global_navigation_python(self):
        driver = self.driver
        driver.get(self.base_url + "/")
        driver.find_element_by_name("drugOne").clear()
        driver.find_element_by_name("drugOne").send_keys("Aspirin")
        driver.find_element_by_xpath("//button[@type='submit']").click()
        driver.find_element_by_link_text("Flushing").click()
        try: self.assertEqual("Gender, Age, and Weight Differences in Drug Interactions", driver.find_element_by_css_selector("h2").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("Flushing", driver.find_element_by_xpath("//p[3]/strong").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("Aspirin", driver.find_element_by_xpath("//strong[2]").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("Gender", driver.find_element_by_css_selector("th").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("# of Reports", driver.find_element_by_css_selector("th.text-right").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        # ERROR: Caught exception [ERROR: Unsupported command [getTable | //table.1.0 | ]]
        # ERROR: Caught exception [ERROR: Unsupported command [getTable | //table.2.0 | ]]
        # ERROR: Caught exception [ERROR: Unsupported command [getTable | //table.3.0 | ]]
        # ERROR: Caught exception [ERROR: Unsupported command [getTable | //table.4.0 | ]]
        try: self.assertEqual("Age", driver.find_element_by_xpath("//table[2]/thead/tr/th").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("# of Reports", driver.find_element_by_xpath("//table[2]/thead/tr/th[2]").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("< 1", driver.find_element_by_xpath("//table[2]/tbody/tr/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("1 To 17", driver.find_element_by_xpath("//table[2]/tbody/tr[2]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("35 To 54", driver.find_element_by_xpath("//table[2]/tbody/tr[4]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("55 To 64", driver.find_element_by_xpath("//tr[5]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("> 65", driver.find_element_by_xpath("//tr[6]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("Not Reported", driver.find_element_by_xpath("//tr[7]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        # ERROR: Caught exception [ERROR: Unsupported command [getTable | //table[3].0.0 | ]]
        # ERROR: Caught exception [ERROR: Unsupported command [getTable | //table[3].0.1 | ]]
        try: self.assertEqual("< 50 Lbs", driver.find_element_by_xpath("//table[3]/tbody/tr/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("50 To 99 Lbs", driver.find_element_by_xpath("//table[3]/tbody/tr[2]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("100 To 149 Lbs", driver.find_element_by_xpath("//table[3]/tbody/tr[3]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("150 To 199 Lbs", driver.find_element_by_xpath("//table[3]/tbody/tr[4]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("200 To 249 Lbs", driver.find_element_by_xpath("//table[3]/tbody/tr[5]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("> 250 Lbs", driver.find_element_by_xpath("//table[3]/tbody/tr[6]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("Not Reported", driver.find_element_by_xpath("//table[3]/tbody/tr[7]/td").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertEqual("BACK TO DRUG REACTIONS LIST", driver.find_element_by_xpath("(//button[@type='button'])[2]").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertTrue(self.is_element_present(By.XPATH, "//table[3]/thead/tr/th[2]/a/span"))
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertTrue(self.is_element_present(By.XPATH, "//table[2]/thead/tr/th[2]/a/span"))
        except AssertionError as e: self.verificationErrors.append(str(e))
        try: self.assertTrue(self.is_element_present(By.CSS_SELECTOR, "span.glyphicon.glyphicon-question-sign"))
        except AssertionError as e: self.verificationErrors.append(str(e))
        driver.find_element_by_xpath("(//button[@type='button'])[2]").click()
        try: self.assertEqual("Flushing", driver.find_element_by_link_text("Flushing").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException, e: return False
        return True
    
    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException, e: return False
        return True
    
    def close_alert_and_get_its_text(self):
        try:
            alert = self.driver.switch_to_alert()
            alert_text = alert.text
            if self.accept_next_alert:
                alert.accept()
            else:
                alert.dismiss()
            return alert_text
        finally: self.accept_next_alert = True
    
    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors)

if __name__ == "__main__":
    unittest.main()
