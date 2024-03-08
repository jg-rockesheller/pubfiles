# Learning Haskell

Using [this book](https://learnyouahaskell.github.io/chapters.html) to learn Haskell.

Bookmark: [7. Modules](https://learnyouahaskell.github.io/modules.html)

---

## 2024.03.01 Notes

* Just finished chapter 2
* I feel like I understand lists better because my calc class is reviewing series and sequences
* I think I'm understanding a little bit of set theory
  * List comprehension makes sense when I think of them like they are loops
* Been mainly using the language through the REPL, just loading in files rather than compiling them
  * Maybe later in the book we will cover compilation, but if not, I'll figure it out
* I think at the end of the book I want to try out an Advent of Code season in Haskell, but I'll see

---

## 2024.03.02 Notes

* Just finished chpater 3, I think I might need to reread it again
* It draws a lot of comparison to generics and type interfaces, which I don't really know much about
  * I do think I understand the concept of a typeclass though, so if I ever have to deal with them in other programming langauges, I can draw parallels to Haskell
* I love the fact that Haskell is statically typed, and it makes sense with how everything is an expression/function and how mutability works in the language
* Upon reread things are clearer
* Type variables are kinda like working with types with the PreProc.

---

## 2024.03.03 Notes

### Chapter 4

* Just finished chapter 4
* Definitely need to reread it to understand everything
* These all feel like variations of `case` or `if - else if - else` in `C`, except more powerful
* ~~I think pattern matching is only ever really useful lists, I would most likely use guards in other scenarios~~
* Reminds me of how powerful expressions are in Haskell
* I've seen `let` and `in` before using Nix

<!-- bruh how do tables work in gfm??? -->
|                  |                                       |
| ---------------- | ------------------------------------- |
| guards           | match against value                   |
| pattern matching | match against value **and structure** |
<!-- weird workaround for me wanting to just have a table with no heading -->
<!-- apparently: https://stackoverflow.com/questions/17536216/create-a-table-without-a-header-in-markdown -->
<!-- I wish I was better at HTML, maybe I'll learn web dev -->

### Chapter 5

* Just finished chapter 5
* I feel like I got the concept first try, especially because I'm somewhat accustomed to recursion in other languages, especially Python
* Pattern matching makes recursion feel very clean and concise
* It tends to be clear what edge cases are
* This chapter was very fun because I tried to implement the functions based off their descriptions without looking at how the book does it first
* I think it will take some time getting accustomed to no loops, but recursion feels really fun

---

## 2024.03.05

* Just finished chapter 6
* Now I'm halfway done with the book!
* This chapter had a LOT of content, so I will probably reread it
* Most of the concepts make sense
* I am most confused by folding, but I think if I review it again I will understand it
* It feels like I am done with most of the core language features (not including ecosystem stuff or common practices)
  * I feel like I learned the atomic parts of the language
  * I felt like I had to learn Haskell from the ground up unlike other languages because of how different I have to think when doing functional stuff
* Many features overlap, but have certain best use cases, so I will need to understand those

---

## 2024.03.07

* Just finished chapter 7
* Pretty long chapter, most of which is just going over functions from `Data.List` and `Data.Char`
* I just skimmed over the functions from `Data.Char`, but I think that's okay
  * I'll just check Hoogle if I need to find something
* Aside from that, nothing I want to say, it's like making libraries in Python
