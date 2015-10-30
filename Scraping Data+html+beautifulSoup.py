
# coding: utf-8

# In[3]:

import requests
from bs4 import BeautifulSoup


# In[4]:

# I am using yellow pages to scrape web for practice, using code from https://www.youtube.com/watch?v=3xQTJi2tqgk
# I want the list and content of the data for search of coffee near charlottesville
#
# obtaining a html
r = requests.get("http://www.yellowpages.com/search?search_terms=coffee&geo_location_terms=Charlottesville%2C+VA")


# In[5]:

# all the html content( the source page data) can be seen from
r.content


# In[6]:

# forming a beautiful soup object
soup = BeautifulSoup(r.content)
soup.prettify()


# In[7]:

# trying to find all links in the page
soup.find_all("a")


# In[10]:

# trying to get all links, here 'a' is used for html tags but it can be anything.
for link in soup.find_all("a"):
    print(link)


# In[13]:

# extracting only the links 'href'
for link in soup.find_all("a"):
    print(link.get("href"))


# In[15]:

# to get the link text
for link in soup.find_all("a"):
    print(link.text)


# In[16]:

# to get both links and link text
for link in soup.find_all("a"):
    print(link.text, link.get("href"))


# In[22]:

# to display the result in a way the html results are shown
for link in soup.find_all("a"):
    print("<a href='{}'>{}</a>".format(link.get("href"), link.text))


# In[24]:

# to find particular href's with 'http' in it
for link in soup.find_all("a"):
    if "http" in link.get("href"):
        print("<a href='{}'>{}</a>".format(link.get("href"), link.text))


# In[36]:

# to get the content
g_data =soup.find_all("div", {"class": "info"})
print(g_data)
# we can see that g_data is a list


# In[38]:

# make it more in a readable format
for item in g_data:
    print(item.text)
# item is a list as well


# In[39]:

# to make it more usable format
for item in g_data:
    print(item.contents)
# it is a set of lists
# we get the h3 class and the info section wrapper


# In[40]:

# gives the names of the caffe's
for item in g_data:
    print(item.contents[0].text)


# In[41]:

# therefore, we have separated the name of the place and other contents
for item in g_data:
    print(item.contents[0].text)
    print(item.contents[1].text)


# In[52]:

# now that if we want only the name of the restaurant
for item in g_data:
    print(item.contents[0].find_all("a", {"class": "business-name"})[0].text)
# as usual 'a' is the tag while inside the tag the 'class' "business name is called and if we want only the text we use 
# text


# In[63]:

# now we want the name of the restaurant and its address
for item in g_data:
    print(item.contents[0].find_all("a", {"class": "business-name"})[0].text)
    print(item.contents[1].find_all("p", {"class": "adr"})[0].text)


# In[69]:

# now we want phone number as well
for item in g_data:
    print(item.contents[0].find_all("a", {"class" : "business-name"})[0].text)
    print(item.contents[1].find_all("p", {"class" : "adr"})[0].text)
    try:
        print(item.contents[1].find_all("div", {"class" : "phones"})[0].text)
    except:
        pass
# this is just a error handling if phone number is not available


# In[71]:

# now if I want to break the address in parts

for item in g_data:
    print(item.contents[0].find_all("a", {"class" : "business-name"})[0].text)
    #print(item.contents[1].find_all("p", {"class" : "adr"})[0].text) ; this gives the whole address
    try:
        print(item.contents[1].find_all("span", {"itemprop": "streetAddress"})[0].text)
    except:
        pass
    try:
        print(item.contents[1].find_all("span", {"itemprop": "addressLocality"})[0].text)
    except:
        pass
    try:
        print(item.contents[1].find_all("span", {"itemprop": "addressRegion"})[0].text)
    except:
        pass
    try:
        print(item.contents[1].find_all("span", {"itemprop": "postalCode"})[0].text)
    except:
        pass
    try:
        print(item.contents[1].find_all("div", {"class" : "phones"})[0].text)
    except:
        pass


# In[ ]:

# this just the first 30 entries but as we can see there are more entries and the url changes in the next page
# so, I can just observe the url I am convert it into a function for getting urls

# initially
url = "http://www.yellowpages.com/search?search_terms=coffee&geo_location_terms=Charlottesville%2C+VA"
url_page2 = url + "&page=" + string(2)

# and then we can create function to get url's
def get_urls(url, 10):
    

