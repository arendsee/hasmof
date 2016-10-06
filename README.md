# hasmof

A Haskell reinterpretation of my Smof utility

# Genesis

Smof was born the first summer of my first graduate year. I programmed it
partly to practice Python and partly for practical parsing of FASTA (pardon the
p's). New functionality accreted to the program haphazardly. Soon it was too
large for its singular CLI interface, so I added subcommands. These multiplied
into ill-thought forms of Cambrian diversity: Retrieve, Search, Qstat, Hstat,
PrettyPrint, Tounk, Idsearch. The mess was remedied by a transition to UNIX
inspired forms. The many oddly named search functions were replaced by a single
`grep` subcommand. Likewise I added `head`, `tail`, `cut`, `wc`, `md5sum` and
`uniq`; all of which followed their UNIX homologs, even keeping the same flags,
but rebasing from lines to FASTA entries. I eventually settled with 17
subcommands, all general but powerful, flexible but intuitive. It became the
only tool I needed for FASTA manipulation and starred in all my
sequence-related scripts. It was so endlessly useful that I began considering
publication. However, I found a published Perl tool, FAST, of similar scope.
Whereas Smof was biologically agnostic, FAST was biologically rich. FAST was
not at all fast, though, since it was built on the porcine, deeply nested,
object-laden Bioperl base; Smof was about twice as fast. Still, FAST was a good
tool, and I did not feel that smof was sufficiently novel to merit publication.

I began to consider reimplementing smof in a faster language, perhaps C. The
coupling of high performance with smof's other charms would, I thought, merit
publication. But I never found the time.

A year later, for reasons unrelated, I decided to learn Haskell. As is my habit
when learning a new language, I made a practice repository and began making toy
programs. One of these was a fasta parser, which I naturally called smof.
Initially I had no intention of raising the child, but I began to see a flicker
of potential in its functional circuitry. Haskell is slower than C, but far
faster than Python. It also is very easy to parallelize. Yet of greater
interest to me is the elegance of functional composition. I can see the outline
of a radically different path to composing pipelines in Haskell.
