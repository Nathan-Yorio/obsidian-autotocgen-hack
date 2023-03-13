# obsidian-autotocgen-hack
A shell script that uses the python module pdf.tocgen by Krasjet to generate tables of content for my pdfs exported from markdown

## Using the script
- make sure you have [pdftocgen](https://github.com/Krasjet/pdf.tocgen) installed with Python
```sh
pip install -U pdf.tocgen
```

- Specify an input pdf, output pdf name for the script, make sure it's executable `chmod +x`
```sh
./pdf_toc_generator.sh blahblah.pdf blahblahoutput.pdf

or...

./pdf_toc_generator.sh "blahblah.pdf" "blahblahoutput.pdf"
```
## How it works

Essentially, I couldn't figure out an easy way to have sidebar tables of content for PDFs that come out of Obsidian. It hasn't been implemented into the editor itself yet as far as I know so I've made this hacky workaround to make it happen at least on the document heading level for me.

First, I used [Krasjet's pdf.tocgen](https://github.com/Krasjet/pdf.tocgen), which allowed me to extract the heading recipe as follows for my theme styling.

- I extracted this original TOML using a dummy pdf export with all 5 heading levels my theme has:

```sh
pdfxmeta -p 1 -a 1 in.pdf "Heading 1" >> recipe.toml
pdfxmeta -p 1 -a 1 in.pdf "Heading 2" >> recipe.toml
pdfxmeta -p 1 -a 1 in.pdf "Heading 3" >> recipe.toml
pdfxmeta -p 1 -a 1 in.pdf "Heading 4" >> recipe.toml
pdfxmeta -p 1 -a 1 in.pdf "Heading 5" >> recipe.toml
```
- yes I'm aware this could be even more automatic, but in order to get the headings you need to know the heading titles for it to pull styles
- since this is only for markdown where my styling isn't changing, this will work for me for every document I export for now

```toml
[[heading]]
# Heading 1
level = 1
greedy = true
font.name = "Inter-ExtraBold"
font.size = 15.025714874267578

[[heading]]
# Heading 2
level = 1
greedy = true
font.name = "Inter-SemiBold"
font.size = 12.020570755004883

[[heading]]
# Heading 3
level = 1
greedy = true
font.name = "Inter-SemiBold"
font.size = 10.292613983154297

[[heading]]
# Heading 4
level = 1
greedy = true
font.name = "Inter-SemiBold"
font.size = 9.391071319580078

[[heading]]
# Heading 5
level = 1
greedy = true
font.name = "Inter-SemiBold"
font.size = 8.414400100708008
```

- then the script dumps this recipe text out to a `recipe.toml`, which gets populated by pdftocgen with the contents of the pdf while generating the output
```sh
pdftocgen "$in" < recipe.toml | pdftocio -o "$out" "$in"
```

- I then remove the `recipe.toml`, because now it's more like a mirrored pdf than a template and can be regenerated.

