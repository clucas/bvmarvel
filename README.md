# Assignment

## Marvel Impossible Travel
We're investigating an impossible travel alert that we noticed was triggered by Spectrum. We need your help to complete our investigation.
## Your Mission Should You Choose to Accept
- Sign up for an api key from the [Marvel Developer Portal](https://developer.marvel.com/).
- Obtain the name, id, description, and picture of Spectrum.
- Obtain the same information for all other characters she's worked with in other comics.
- Save the information in a database so that we can continue our investigation.
- Send us a link to a repo that contains a Dockerfile for spinning up the environment needed to run your script as well as a readme explaining what we need to do use your tool to exfiltrate this information.
Note: The api has a limit of 3000 calls/day so please be careful with your tools.

# Application

A running version is deployed with containers on heroku: https://aqueous-ravine-19157.herokuapp.com/characters?search=spectrum

# Usage
* Reset the data: Under "Search characters", click the "Destroy All" link to reset the data
* Launch the search: Enter "Spectrum" in the text field  and click "Search". It may take up to a minute to load and display the searched Superhero (Spectrum) and all the other organizations and characters she worked with.
* Results:
    - https://aqueous-ravine-19157.herokuapp.com/characters?search=spectrum
    - https://aqueous-ravine-19157.herokuapp.com/characters.json?search=spectrum

# Methodology
API calls used to retrieve the data from the Marvel API:
  - Search for the Spectrum character: /v1/public/characters?name=spectrum
  - The response includes the number of stories available for the Spectrum character (32)
  - Retrieve the 32 stories for the Spectrum character: v1/public/characters/1010705/stories?limit=32
  - List the characters for each story: /v1/public/stories/:strory_id/characters 
 
 The application lists all these characters, it also creates all the stories and creates a relationship between stories and characters.
 The challenge app contains a link to the associated characters ("Characters for this story") for each story on the story page: https://aqueous-ravine-19157.herokuapp.com/stories/1.
 