# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class HeaderAndFooterNavigationLinks(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://gsa-ads-2-elbwebex-15wqptfab7c7o-1537924130.us-east-1.elb.amazonaws.com/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_header_and_footer_navigation_links(self):
        driver = self.driver
        driver.get(self.base_url + "/")
        driver.find_element_by_link_text("Disclaimers").click()
        driver.find_element_by_link_text("About the Tool").click()
        driver.find_element_by_xpath("(//a[contains(text(),'About the Tool')])[2]").click()
        driver.find_element_by_xpath("(//a[contains(text(),'Disclaimers')])[2]").click()
        driver.find_element_by_link_text("Search").click()
        driver.find_element_by_css_selector("img[alt=\"openFDA logo\"]").click()
        driver.back()
        driver.find_element_by_css_selector("a[title=\"Aquilent Web Site\"] > img[alt=\"Aquilent logo\"]").click()
        driver.back()
    
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
