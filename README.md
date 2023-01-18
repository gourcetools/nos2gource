
# <b>nos2gource</b>                  <br>
<img src="https://img.shields.io/badge/License-MIT-orange.svg"> <br> <br>
 <img src="https://nostr.build/i/2226.png" alt="Combined" width="500px"> <br> <br>
  <img src="https://user-images.githubusercontent.com/120996278/213193492-dee2414e-4127-4d27-ba41-c6e6fcbc68bb.png" alt="rickrolld" width="500px"> <br> <br>



# <b>🍩 What is nos2gource?</b><br>
<br>
<b>nos2gource is a a collection of bash script made to convert nostr events to Gource visualisation.</b><br>
It's main purpose it to download events from <b>multiple</b> relays, create logs, combine them into one big file that we can open with Gource.<br>
It's just...funny.. still early stage. im sorry.<br>
<br>

# <b>⚙️ Requirements:</b><br>
- `nostcat` , `gource` <br>
- https://github.com/blakejakopovic/nostcat <br>
- https://github.com/acaudwell/Gource/    <br>
- Optional: `FFmpeg` for recording with gource<br>
<br>

 
# <b>✔️ How to use nos2gource?</b><br>
1) 📜  Open <b>relays.txt</b> and replace links with desired URLs - one link per line.<br>
2) 🧰  Launch `./src/src/run-all.sh` , you can edit the variables inside each script to change how many events you ask each relays. 
3) ⌛  Wait
4) 😃  You should see a gource now.<br>
<br>


🙋‍♂️ Need help? Telegram: <b>@bitpaint</b> | Twitter: <b>@bitpaintclub<br></b>

you can edit relay list inside the src/Relays.txt
`cargo install nostcat` <br>
`git clone https://github.com/gourcetools/nos2gource` <br>
`cd ./nos2gource` <br>
edit relays.txt and put the relays you want to get infor from, one per line. <br>
`./src/src/run-all.sh` <br>
