@echo off
for %%x in (
    DayOne/FirstChallenge/
    DayOne/SecondChallenge/
    DayTwo/FirstChallenge/
    DayTwo/SecondChallenge/
    DayThree/FirstChallenge/
    DayThree/SecondChallenge/
) do (
    echo Building %%xMain.elm
    elm-make %%xMain.elm --output=%%xindex.html
)
