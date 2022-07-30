# Features
* Download webnovels from novelfull.com.
* Use a chapter url and specify number of chapters to download.
* Download is in html format.
* HTML file is in page format with one chapter shown at a time.
* TOC for chapter navigation.
* Hover to the left of page to make TOC visible.
* Hover to the left of a paragraph.
  Click on the newly visible element to select the text till bottom.
  This is helpful if you want to use text to speech on selected text.

# How to use

Build

```
sudo apt install <nodejs>
cd <repository directory>
npm i
npm run build
```

Subsequent usage
```
npm run exec
# Input the url of a chapter from novelfulls.com
# Input the number of chapters to download.
# Wait for some time for a html file to be created.
```
