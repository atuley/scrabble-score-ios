To use this you need to have cloned `https://github.com/atuley/spring-scrabble-api.git`

Once you have cloned the Spring API, insert your local IP address into line 24 of `ScrabbleService`

`let scrabbleUrl = "http://Insert IP address here:8080/score?word=\(word)"`

After that cd into the Spring API -> complete and then run `gradle bootRun`. Fire up the iOS simulator and you should be able to get a score back based on an entered word in the text field.




