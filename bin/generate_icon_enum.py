#!/usr/bin/env python3

import argparse
import json
import os
from dataclasses import dataclass
from string import Template

TEMPLATE = Template(
    """public extension Icon {
$icons

  static let allIcons: [Icon] = [
$all_icons
  ]
} 
"""
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-file", action="store", dest="input_file", type=str, required=True)
    parser.add_argument(
        "--output-file", action="store", dest="output_file", type=str, required=False
    )

    return parser.parse_args()


@dataclass(frozen=True)
class Icon:
    name: str
    unicode: str


def camel_case(input: str) -> str:
    temp = input.replace("-", " ").replace("_", " ").title().replace(" ", "")
    return f"{temp[0].lower()}{temp[1:]}"


def swift_valid_var_name(input: str) -> str:
    if input in ["class", "extension", "public", "repeat"]:
        return f"`{input}`"
    elif input == "3DRotation":
        return "threeDRotation"
    else:
        return input


def swift_icon_def(icon: Icon) -> str:
    return (
        f"\n  static let {swift_valid_var_name(camel_case(icon.name))}"
        f' = Icon(name: "{icon.name}", unicode: "\\u{{{icon.unicode}}}")'
    )


if __name__ == "__main__":
    args = parse_args()
    input_file_path = os.path.expanduser(args.input_file)

    with open(input_file_path, "r") as input_file:
        ijmap = json.load(input_file)["icons"]
        icons = [Icon(value["name"], key) for key, value in ijmap.items()]

        replacement = ""
        all_icons = ""
        for icon in icons:
            replacement += swift_icon_def(icon)
            all_icons += f'\n    .{swift_valid_var_name(camel_case(icon.name))},'

        result = TEMPLATE.substitute(icons=replacement, all_icons=all_icons)
        print(result)

        if output_file_path := args.output_file:
            with open(os.path.expanduser(output_file_path), "w") as output_file:
                output_file.write(result)
