## LMI for All Mod
# Hot Jobs

---

### Contributors

* [Max Shelley](https://twitter.com/maxshelley)
* [Anders Fisher](https://twitter.com/atleastimtrying)

---

Split over two separate hack days a couple of months apart, we aimed to create an app that would allow those looking for career guidance to visualise the density of job vacancies for a specific role or industry in the UK. In the second hack, we were able to pull live data and provide more contect about the potential locations that the searches had brought up. We were able to get crime statistics working, and the beginnings of property price information, but time got the better of us. We had also sourced API's for and were keen to implement property rental prices, cost-of-living data and other contextual information.

---

### Data used


* LMI Vacany Data - We used this data to draw the heat map. We were limited here as the API will only return 50 jobs, so we fed back to the API team that the ability to iterate through more data with multiple API requests would be great.
* UK Crime Statistics - http://data.police.uk - We used this data to get crimes for areas around job vacancies.
* Zoopla House Price API - http://developer.zoopla.com - We started to use this data to get house price information around job vacancies.

---

### How to run

Usual Rails process, there's nothing fancy going on that I can remember.

---

### Improvements

The [presentation we gave at the Hack](https://docs.google.com/presentation/d/1n1Aq3Zedtvgk42Y4Dfwr399jdMbiUZPG1BckmRURNb8/edit?usp=sharing) lists some limitations and upsides.

* The vacancies API is limited to 50. We could have a much hotter heatmap. This is being pulled from the Universal Jobmatch API, so we'd need to write a scraper or something like that.
- Need more time for more integrations.
