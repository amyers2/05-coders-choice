# Coder's Choice

In this assignment, you will think up an application that makes good use of some of the features or Elixir and BEAM, and implement it.

It may be a Phoenix application. It may be a console program. It might also be just a server application. Whatever it is, it must be something that takes advantage of the parallelism inherent in Elixir, and it must show your understanding of the concepts involved.

There are a few constraints:

it must have at least 4 modules and 100 lines of original code (not counting comments, @doc strings, and blank lines).
It must have at least one supervisor and at least one genserver. If you are writing a Phoenix app, the supervisor and servers must be in addition to any that Phoenix runs for you.
I must be able to run it on my machine without onerous setup. I understand that I may have to run mix ecto.create—that's fine. But I'm not going to install and run a Minecraft server just so your code can talk to it :)

## The Process


#### Inception

First dream up something that meets the criteria and that sounds like it might be fun. Maybe you put a web interface on the hangman game, or write a server that solves some problem in parallel. Perhaps yoo want to run a simulation verifying the winning strategy in the Monty Hall Paradox (Links to an external site.)Links to an external site. a million times. Or look for phrases from Shakespeare in song lyrics. Or…

Now document it as a proposal.

To do this, fork the github repo (Links to an external site.)Links to an external site..  

You'll find a file called proposal.md in the repo you forked. It contains guidelines. Basically, I need you to tell me:

what your code will do
how you'll structure it in terms of servers and supervisors, and your initial thoughts on the modules you'll write
Sent this to me as a PR (remember to add your name and ID to the request)

#### Feedback

I'll do my best to get back to you quickly. I'll do this by annotating your proposal. I'll tell you it

is approved
is approved, but some tweaks needed
needs some changes
In the first two cases, you're free to start coding. (In the second, you can start if you agree with the tweaks I suggest. If you don't, we can discuss things.)

In the third case, we can discuss the changes if you want. You'll need to resubmit to get approval.

#### Implementation

As you are coding, I encourage you to push changes to your github account frequently. (By this, I mean do regular add/commit/pushes. Don't send me merge requests for every push you do).

However, I do require you to generate 3 merge requests. 

The first two are sanity checks. Submit your code via a merge request. In the comment, include your name, id, and "Sanity Check 1" (or 2). I'll look at these and just confirm you're headed it the right direction. I don't want you to get to the last week and then discover that your design was wrong.

The third merge is the final submission.

Last acceptable dates for all three are in the timetable below.

## Grading

This project counts for 30% of the course total (ignoring any extra credit grades).

I will give good grades for

* an ambitious scope
* projects that make great use of Elixir or BEAM
* projects that work
* projects that include tests

I will deduct marks for

* bad layout
* duplication
* overly long functions
* code not expressed in a functional style

To give you an idea, a working program that is unambitious, boring, and has no tests will put you in B- to B territory before I subtract any deductions.

The two sanity checks will not be graded. However, I will deduct 5 marks for ones that you fail to submit on time.

All code submitted for grading must be 100% your own. You're free to use libraries available in hex.pm. Please cite any unusual algorithms.

## The Timeline

**Now**	start working on your proposal. Once you have something, send it to me via PR. The sooner I get it and approve it, the sooner you can start work.
**Nov 5**	All proposals must be in by midnight.
**Nov 15** & 22	sanity check-ins. These are not optional, and 4 points will be deducted for any missing one
**Nov 26**	All projects will be submitted by midnight. Absolutely no exceptions
