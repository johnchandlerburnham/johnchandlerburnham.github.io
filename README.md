# www.johnchandlerburnham.com

These are some rough developments notes for my own use. I don't want to have to
remember/reverse-engineer my website in case I lose state. I'll probably
do a proper write-up for general audiences at some point, since I think this is
actually a pretty neat way to get your hands dirty using Haskell for something
real. Hakyll is pretty unique in that it's more of a library for writing your
own static site generator in Haskell, rather than a static site
generator per se. 

Dependencies:
1. [Haskell Stack](https://docs.haskellstack.org/en/stable/install_and_upgrade/)
   Since I'm on [Arch Linux](www.archlinux.org): `pacman -S stack`
2. [Hakyll](https://jaspervdj.be/hakyll/): `stack install hakyll`
3. [rsync]( https://linux.die.net/man/1/rsync): `pacman -S rsync`

  The site is hosted on Github Pages, which grabs the site files from the master
branch. Files are generated from markdown and other resources on the hakyll
branch (orphan branch that almost acts as a whole separate repo). I used 
this [tutorial](https://jaspervdj.be/hakyll/tutorials/github-pages-tutorial.html)
for hooking up hakyll and Github Pages, with some modifications. I wrote a
custom deployCommand script, partly based on the above and partly base on this
excellent
[one](https://github.com/blaenk/blaenk.github.io/blob/source/src/deploy.sh) by
Blaenk.Denum. 

  The basic development cycle works as follows:

1. Edit content in files on the hakyll branch.
2. Commit changes to those files.
3. Run `stack exec site deploy`, running the script deploy.sh which stashes any
uncommitted changes, runs the hakyll.hs site generator on the latest commit in
the hakyll branch, then copies all the output files over to the master branch
and commits them. This publishes the website.

Any changes to hakyll.hs though requires an additional `stack build` before
deploying.

Site design began as a mashup of Katy Chuang's [haskell.org CSS
template](https://github.com/katychuang/hakyll-cssgarden/blob/master/default_theme/css/haskell.org.css)
and Ethan Schoonover's [Solarized
colorscheme](http://ethanschoonover.com/solarized) and developed from there.

I got https working over Github Pages by going through CloudFlare and following
this [setup
guide](https://blog.cloudflare.com/secure-and-fast-github-pages-with-cloudflare/)
(more or less)

