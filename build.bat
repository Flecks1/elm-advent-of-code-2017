@echo off
for %%x in (
    DayOne/FirstChallenge/
    DayOne/SecondChallenge/
    DayTwo/FirstChallenge/
    DayTwo/SecondChallenge/
    DayThree/FirstChallenge/
    DayThree/SecondChallenge/
    DayFour/FirstChallenge/
    DayFour/SecondChallenge/
    DayFive/FirstChallenge/
    DayFive/SecondChallenge/
) do (
    echo Building %%xMain.elm
    elm-make %%xMain.elm --output=%%xindex.html
)
