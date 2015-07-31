#!/bin/bash
#Takes all Intro To Linux files and makes a pdf out of them
cat Chapter1.md >> IntroToLinux.md
cat Chapter2.md >> IntroToLinux.md
cat Chapter3.md >> IntroToLinux.md
cat Chapter4.md >> IntroToLinux.md
cat Chapter5.md >> IntroToLinux.md
cat Chapter6.md >> IntroToLinux.md
cat Chapter7.md >> IntroToLinux.md
cat Chapter8.md >> IntroToLinux.md
cat Chapter9.md >> IntroToLinux.md
cat Chapter10.md >> IntroToLinux.md
cat Chapter11.md >> IntroToLinux.md
cat Chapter12.md >> IntroToLinux.md
cat Chapter13.md >> IntroToLinux.md
cat Chapter14.md >> IntroToLinux.md
cat Chapter15.md >> IntroToLinux.md
cat Chapter16.md >> IntroToLinux.md
cat Chapter17.md >> IntroToLinux.md
cat Chapter18.md >> IntroToLinux.md
#TODO: Reference convertNotes.txt for steps before conversion

pandoc -f markdown_github IntroToLinux.md -o IntroToLinux.pdf
rm IntroToLinux.md
