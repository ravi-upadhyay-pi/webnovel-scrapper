import { Driver } from './driver';
import { JSDOM } from "jsdom";
import * as readline from "readline";

const debug = false;

const main = async () => {
    console.log("Enter Chapter URL:");
    const chapterUrl = debug
        ? "https://novelfull.com/cultivation-chat-group/chapter-363-hmph-ill-pass-by-the-doors-of-home-three-times-without-entering.html"
        : await getInput();
    console.log("Enter number of chapters to load:");
    const chapterCount = debug
        ? 2
        : parseInt(await getInput());
    const { window } = await JSDOM.fromURL(chapterUrl);
    const $ = require("jquery")(window) as JQueryStatic;
    await new Driver(window, $, chapterCount).fetch();
};

async function getInput(): Promise<string> {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    return new Promise<string>(res => {
        rl.on('line', (line) => {
            res(line);
            rl.close();
        });
    });
}

main();
