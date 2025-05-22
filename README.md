# Simple Contrast Checker

Simple Contrast Checker is a user-friendly web app designed to help designers and accessibility professionals check the contrast between two hex colors in order to comply with WCAG (Web Content Accessibility Guidelines) AA and AAA level requirements.

The web app uses two APIs to request the information:

- **WebAIM Contrast Checker API** — provides the contrast ratio between the checked colors and pass/fail statements for each level for normal and large texts and UI elements.
- **The Color API** — provides color names and a contrast value (black or white) according to the requested color.

## Prerequisites

- Ruby version: `3.3.0`

## Getting started

To run this app:

1. Clone this repository
   ```bash
   git clone https://github.com/karenbarbe/contrast_checker.git
   cd contrast_checker
   ```
2. Run development server `bin/server`
3. Set up `bin/setup`

## User stories

- As a user, I want to enter two hex color codes to check the contrast between them.
- As a user, I want to easily identify which color is being used for the foreground and background respectively.
- As a user, I want to receive clear messages when a color combination passes or fail a requirement.
- As a user, I want to visualize how the compared colors look like when in use.

## Functional specs

[Specs and requirements](https://gist.github.com/karenbarbe/e306a957d41166f15420e3aa389026b1)
