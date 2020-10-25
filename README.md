# Final Project
Use this `REAMDE.md` file to describe your final project (as detailed on Canvas).

## Domain of interest
As we've discussed, data science can expose underlying patterns in any domain that uses or collects data (which is nearly any domain). Anything from the [forced relocation of homeless individuals](https://www.theguardian.com/us-news/ng-interactive/2017/dec/20/bussed-out-america-moves-homeless-people-country-study) to how people [gender representation](https://pudding.cool/2017/09/this-american-life/) in the media, data can expose interesting (and actionable) patterns. In this section, you'll identify a domain that you are interested in (e.g., music, education, dance, immigration -- any field of your interest) and answer the following questions in your `README.md` file:


_Why are you interested in this field/domain?_ <br>
We’re interested in this field because we think the data is relevant to the current movements and protests going on today, as well as how some people are handling the pandemic. The Human Fredom Index have indicators that are based on crime and violence, freedom of movement, and legal discrimination against same-sex relationships, which we think have been recent large topics of debate in the recent years.  Through all the protests and controversy,  we want to see how these freedom indexes have changed over time, as well as what countries have been progressive enough for these indexes to increase.

_What other examples of data driven projects have you found related to this domain (share at least 3)?_ <br>
[THE HUMAN FREEDOM INDEX PROVIDES A SNAPSHOT OF GLOBAL LIBERTY](https://www.atlasnetwork.org/news/article/the-human-freedom-index-provides-a-snapshot-of-global-liberty) <br>
[The Human Freedom Index 2019](https://www.fraserinstitute.org/studies/human-freedom-index-2019) <br>
[The Human Freedom Index: A Global Measurement of Personal, Civil, and Economic Freedom](https://www.cato.org/sites/cato.org/files/human-freedom-index-files/human-freedom-index-2015.pdf)

_What data-driven questions do you hope to answer about this domain (share at least 3)?_ <br>
- Does the size of government affect freedom?
- What countries have the highest freedom index? What attributes contribute to this?
- How have these metrics changed over time for different countries?
- What events seem to have been the trigger for changes in these indexes?
- Which country has been the most progressive in their freedom indexes?

We strongly suggest that you complete this section first, discussing what you might want to learn, then move forward with the data discovery process.

## Finding Data
We are lucky enough to live in a time when there is lots of publicly available data made possible by governments, journalists, academics, and companies. In this section, you will identify and download at least 3 sources of data related to your domain of interest described above (into a folder you create called data/). You won't be required to use all of these sources, but it will give you practice discovering data. If your data is made available through a Web API, you don't need to download it. For each source of data, provide the following information:

_Where did you download the data (e.g., a web URL)?_ <br>
[Link 1](https://www.kaggle.com/doyouevendata/cato-2017-human-freedom-index) <br>
[Link 2](https://www.kaggle.com/thaddeussegura/cleaned-human-freedom-index-20082017) <br>
[Link 3](https://www.kaggle.com/gsutters/the-human-freedom-index?select=hfi_cc_2019.csv)

_How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?_ <br>
- This first dataset is a copy of the 2017 Human Freedom Index dataset released by the Cato Institute, using 2015 data and index-ranks human freedoms in various countries around the world
- The second dataset contains a sequence of hierarchical related metrics rated from 0 to 10, with each record corresponding with a country. The data itself in original form can be found [here](https://www.cato.org/human-freedom-index).
- The third dataset is co-published by the Cato Institute, the Fraser Institute, and the Friedrich Naumann Foundation for Freedom.

_How many observations (rows) are in your data?_
- Link 1: 159
- Link 2: 154
- Link 3: 162

_How many features (columns) are in the data?_
- Link 1: 114
- Link 2:  13
- Link  3: 120

_What questions (from above) can be answered using the data in this dataset?_
- What country has the current highest HFI?
- What country has grown the most in HFI?
- Does a larger government size usually trend towards a higher or lower HFI?
