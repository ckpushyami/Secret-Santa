# Secret Santa

This is a crude R application to create a Secret Santa list that does not have (1) individuals giving to themselves or (2) individuals giving to their partners. These are important because my group of friends from College has a few couples, and for fun they do not want to be paired for this! More cheer for everyone else!

Then, based on a function slightly altered from the [Ponyexpress Package](https://github.com/ropenscilabs/ponyexpress), the results are emailed out to the participants so that even the host does not know who has who. This include a column for the receiver's address, since we are across the country (and the Pacific Ocean).

##Directions

1. Download these files including the santaprep.csv.
2. Edit the santaprep.csv file to include all of your participants and their relevant info. It is important to have partners/family members who do not wished to be paired to have the same last name, because that is how the program makes sure not to match them.
3. Plug in the host's information for their email address and edit the body of the email text to your liking (for instance, we usually shoot for gifts around $50). You could also probably add in a column of interests if you would like to (though this would have to be with the santaprep.csv).
4. Run the program and engage in some secret santa fun!
5. The program generates a final .csv file that contains the master list so that the host can make sure everyone gets a gift or check up if there are issues.

##Thanks!

This program is heavily based upon the sample() function and the tidyverse to recreate data frames. I don't believe this is the most efficient or elegant solution to this problem, but it works well enough with my test files, at least. This program likely has snippets of codes taken from others, and there are some great blogs that have tackled this issue in R that contributed to my thinking in this area including but not limited to: [Tristan Mahr's graphing example](https://www.tjmahr.com/secret-santa-graph-traversal/), [Sarah Lotspeich's and Lucy D'Agostino McGowan's example and their ponyexpress integration ](https://livefreeordichotomize.com/2017/11/15/secret-sampling/), and [David Selby's secret santa example](https://selbydavid.com/2016/12/07/santa/). Thanks so much all for helping me create my real first program! 

## Under the hood

Basically, this program uses sample() within a repeat loop to create dataframes, test them against the above conditions, and repeat until a dataframe has been completed which satisfies the above. Then, this is emailed out!