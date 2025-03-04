# Denali Analysis 

Created from [brieflow-analysis](https://github.com/cheeseman-lab/brieflow-analysis) template.

To pull from the brieflow-analysis repository:

1) Add brieflow-analysis as reference:
`git remote add template https://github.com/cheeseman-lab/brieflow-analysis`
2) Pull from brieflow-analysis main:
`git pull template`
3) Merge from brieflow-analysis main into denali-analysis main
`git merge -X theirs template/main --allow-unrelated-histories`
**Note**: This will automatically use brieflow-analysis code during any merge conflicts!
