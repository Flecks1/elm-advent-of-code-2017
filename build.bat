@echo off
for %%x in (
    DayOne/FirstChallenge/
    DayOne/SecondChallenge/
) do (
    echo Building %%xMain.elm
    elm-make %%xMain.elm --output=%%xindex.html
)
