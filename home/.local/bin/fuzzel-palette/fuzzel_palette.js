#!/usr/bin/env bun
import { $ } from "bun";
import { writeFile } from "fs/promises";
import { resolve, join } from "path";

//TODO move this to individual JSON on homescreen
//TODO make individual config for the picker

const palette = {
  bg: "#3b3228",
  bg95: "#43392d",
  bg75: "#4c4134",
  altbg: "#5d4f40",
  bg25: "#6b6055",
  sand: "#c1a387",
  fg: "#afd2e9",
  scarlet: "#e86045",
  moss: "#92a650",
  celadon: "#ace1af",
  orange: "#e68d53",
  saffron: "#f8e2a0",
  cyan: "#3eccbe",
  grey: "#868686",
};

const iconDir = join(import.meta.dir, "ico");

for (let k in palette) {
  await writeFile(
    join(iconDir, palette[k] + ".svg"),
    `
<svg width="128" height="128" xmlns="http://www.w3.org/2000/svg">
  <rect width="128" height="128" fill="${palette[k]}"/>
</svg>
`,
  );
}

const picker =
  await $`fuzzel --dmenu --config ${join(import.meta.dir, "fuzzel.ini")} < ${Buffer.from(
    Object.keys(palette)
      .map((x) => x + "\0icon\x1f" + join(iconDir, palette[x] + ".svg"))
      .join("\n"),
  )}`
    .quiet()
    .nothrow();

const color = palette[picker.text().trim()];

$`wl-copy ${color}`.then(() => 0);
process.exit();
