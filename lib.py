from linkedin_scraper import Person, actions
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager


def find_friends(email: str, password: str, linkedin_person_url: str):
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    driver = webdriver.Chrome(ChromeDriverManager().install(), options=chrome_options,)

    actions.login(
        driver, email, password
    )  # if email and password isnt given, it'll prompt in terminal
    person = Person(linkedin_url=linkedin_person_url, contacts=[], driver=driver)

    print(f"Person: {person.name}")
    print("Person contacts: ")

    for contact in person.contacts:
        print(f"Contact: {contact.name} - {contact.occupation} -> {contact.url}\n")

    print(len(person.contacts))
