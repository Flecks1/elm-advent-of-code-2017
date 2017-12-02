@echo off
for %%x in (
    DayOne/
) do (
    echo Building %%xMain.elm
    elm-make %%xMain.elm --output=%%xindex.html
)
