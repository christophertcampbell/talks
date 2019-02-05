# Quick Guide to SASS

By Chris Campbell, &copy;2019; License: MIT

## What is SASS?

SASS is an extension to CSS, providing several developer-friendly features for easier development.
* All plain CSS is also valid SASS.  Just change the file extension from .css to .scss.
* Browsers do NOT directory support SASS. SASS must be pre-compiled to CSS.
* Official info: [SASS Official Guide](https://sass-lang.com/guide)

## Installing the SASS compiler

* NPM
	* Install globally: `npm install sass -g`
	* Install in a NPM project: `npm install sass --save-dev`
* Native installers
	* There are also native installers available for Windows, Mac and Linux, but I tend to install SASS as a Node package so that team members without SASS installed can just check out the project and run `npm install`.

## Compiling SASS to CSS
To compile SASS to CSS, use the SASS CLI directly or as part of an NPM script.
* Simple CLI usage:
	* Single entry point: `sass src/scss/style.scss dist/bundle.css`
	* Entire directory: `sass src/scss:dist`
	* Minimized output in watch mode:  `sass src/scss:dist --style compressed --watch`

## Features of SASS

### 1. Partials

* Partial files allow organizing CSS into manageable chunks.
* Partial files can be imported in different combinations to create diferent CSS bundles.
* Prefix partials with an underscore (_) to prevent them from being compiled as top-level entry points

#### Example file structure with partials
```
project/
├── dist/
│   └── bundle.css
└── src/
    └── scss/
        ├── partials/
        │   ├── _variables.scss
        │   ├── _typography.scss
        │   └── _main.scss
        └── style.scss
```   

### 2. Nesting

* Nest CSS rules instead of using long, repetetive strings of selectors.
* Allows better organization of styles, and better readability.
* Change a parent selector in one place rather than many.

The following is equivalent to `main .row.row3 > div`:

```scss
main {
	margin-left: 4em;
	margin-right: 4em;

	.row {
		margin-bottom: 1.5em;

		&.row3  {
			background-color: #d1d6fa;
			
			> div {
				...
			}
		}
	}
}
```

### 3. Variables

* Define variables for repeated use throughout (ie: common colors, widths, etc).
* Variable names are prefixed with a `$`.

```scss
// Define the variable
$primary_color: red;

// Use the variable
.content {
	.accent {
		color: $primary_color;
	}
	.accent-border {
		border: 1px solid $primary_color;
	}
}
```

### 4. Extensions

* Define groups of common rules that can be used in multiple styles.
* Extensions are prefixed with `%` and are included by: `@extend %my-extension`.
* Extensions can include nested rules.

```scss
// Define the extension
%padded-border {
	border: 1px solid #333;
	padding: 1em;

	// Nested rules are permitted
	.inner-element {
		border: 1px dashed #333;
		padding: .5em;
	}
}

// Use the extension
.my-element {
	@extend %padded-border;

	// Additional style rules
	color: blue;
	font-style: bold;
	...
}
```

### 5. Mixins

* Mixins are very similar to extensions, with the addition of accepting variables for customizing their rules
* Mixins are defined with `@mixin` and included with `@include`.
* Mixins can include nested rules.

```scss
// Define the mixin
@mixin colored-background($background_color, $text_color, $link_color) {
	background-color: $background_color;
	color: $text_color;

	// Nested rules are permitted
	a {
		color: $link_color;
	}
}

// Use the mixin
.my-element {
	@extend %padded-border;
	@include colored-background(#efefef, #333, red);

	// Additional style rules
	color: blue;
	font-style: bold;
	...
}
```

### 6. Math Operators

* Basic math operators can be used in SASS
* Allowable operators: `+`, `-`, `*`, `/`, `%`
* Math operators can be used with variables

```scss
.my-element {
	width: 1000px * 50%;
}

.another-element {
	width: 600px / 960px * 50%;
}

.a-third-element {
	max-width: $max_content_width + 200px;
}
```

### 7. Comments

Comments will be handled in different ways depending on whether you compile in compressed (minimized) mode or not.

* Single-line comments (`// A single line comment`):
	* Will never be included in the output, regardless of compressed or un-compressed
* Multi-line comments (`/* A multi-line comment */`):
	* Will be included in un-compressed output
	* Will NOT be included in compressed output
* Important comments (`/*! An important multi-line comment */`):
	* Will always be included in the output, regardless of compressed or un-compressed

### 8. Source Maps

The SASS CLI generates a source map for each bundle (`bundle.css.map`).  The source map allows the browser's developer tools to show exactly which partial a particular style rule is contained in.