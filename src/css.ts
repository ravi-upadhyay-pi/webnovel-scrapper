export const css = `
  * {
    box-sizing: border-box;
    font-family: Georgia;
    margin: 0;
    padding: 0;
    color: black;
    text-decoration: none;
  }
  a {
    color: blue;
  }

  a:visited {
    color: #4848e3;
  }

  a:hover {
    color: coral !important;
  }

  .button {
    padding: 8px;
    font-weight: 600;
    color: darkred;
    border: 1px solid black;
    background: aliceblue;
    border-radius: 2px;
  }

  .index {
    position: fixed;
    top: 0px;
    height: 100%;
    width: 1px;
    overflow: scroll;
    display: flex;
    flex-direction: column;
    background: #ffe1e1;
    transition: 0.5s ease-out;
    box-shadow: 6px 0px 36px black;
  }

  .index:hover {
    display: flex;
    width: 250px;
    user-select: none;
  }

  .index-item {
    border-bottom: 1px solid #464646;
    border-right: 1px solid black;
    padding: 6px;
    font-size: 12px;
    user-select: none;
    width: 250px;
    color: #000094;
    font-weight: 500;
  }

  .index-item:hover {
    color: #007110;
    font-weight: 600;
    background: cornsilk;
  }

  :target {
    display: block !important;
  }

  .book-title,
  .chapter,
  .end {
    display: none;
    width: 800px;
    margin-inline: auto;
    margin-block: 24px;
  }

  .book-title {
    margin-top: 24px;
    font-size: 50px;
    font-weight: bold;
    text-align: center;
    font-family: Georgia;
    user-select: none;
  }

  .chapter {
    text-align: justify;
    border: 1px solid black;
    box-shadow: 0px 0px 30px -8px black;
  }

  .chapter-link {
    margin-left: 30px;
  }

  .chapter-title {
    font-size: 50px !important;
    padding: 24px;
  }

  .chapter-content {
    padding: 10px 30px;
  }

  .chapter-content > p {
    margin-bottom: 10px;
  }

  .chapter-nav-bottom, .chapter-nav-top {
    display: flex;
    padding: 24px 30px;
    place-content: space-between;
    background: #ffe4e4;
    border-top: 1px solid black;
    user-select: none;
  }

  .end {
    font-size: 60px;
  }

  .intermission {
    margin-block: 16px;
    text-align: center;
    background: #7070ff;
    color: white;
  }

  .selector {
    height: 10px;
    width: 10px;
    position: relative;
    left: -20px;
    top: 14px;
  }

  .selector:hover {
    background: darkgrey;
  }
`;
