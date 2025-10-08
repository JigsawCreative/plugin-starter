# 🧩 Converting Plugin Starter to a New Project

Follow these steps to convert this starter into a new WordPress plugin
project --- either as a **fresh build** or by applying the starter to an
**existing plugin**.

------------------------------------------------------------------------

## 🗂️ Project Structure Overview

Typical folder layout:

    my-plugin/
    ├── src/                # Core PHP source files (classes, helpers)
    ├── assets/             # Source JS, CSS, and images
    ├── dist/               # Compiled build output (minified JS/CSS)
    ├── gulpfile.js         # Gulp tasks for CSS pipeline
    ├── rollup.config.js    # JS module bundler config
    ├── package.json        # NPM dependencies and build scripts
    ├── composer.json       # PHP dependencies and autoloading
    ├── phpcs.xml           # CodeSniffer ruleset (WordPress standard)
    └── .github/workflows/  # CI setup for PHPCS

------------------------------------------------------------------------

## 1. 🏗️ Starting Point

You can use the starter in two ways:

### 🆕 New Plugin

Clone or download the starter:

``` bash
git clone https://github.com/yourname/plugin-starter.git my-plugin
cd my-plugin
```

### 🔁 Existing Plugin

If you already have a plugin folder (e.g. `tm-custom-gallery`) and want
to apply the starter:

1.  Copy the following from the starter into your plugin directory:

        gulpfile.js
        rollup.config.js
        package.json
        composer.json
        .gitignore
        phpcs.xml
        .github/workflows/phpcs.yml

2.  If you already have `src/` or `includes/` folders, merge rather than
    overwrite.

3.  Remove any duplicate or outdated build/config files.

------------------------------------------------------------------------

## 2. ⚙️ Update Project Metadata

Edit these to match your new project name and namespace:

  -----------------------------------------------------------------------------
  File                   Change                    Example
  ---------------------- ------------------------- ----------------------------
  `plugin-starter.php`   Plugin header info        Change "Plugin Name",
                                                   "Description", "Text Domain"

  Folder name            Rename                    `plugin-starter` →
                                                   `tm-custom-gallery`

  PHP classes            Namespace and prefix      `Plugin_Starter` → `TMCG`

  Text domain            Replace all               → `tm-custom-gallery`
                         `plugin-starter`          
                         references                
  -----------------------------------------------------------------------------

You can automate replacements with:

``` bash
grep -rl "plugin-starter" . | xargs sed -i '' 's/plugin-starter/tm-custom-gallery/g'
grep -rl "Plugin_Starter" . | xargs sed -i '' 's/Plugin_Starter/TMCG/g'
```

------------------------------------------------------------------------

## 3. 🧱 Install Dependencies

### PHP / Composer

Run:

``` bash
composer install
```

If you haven't set up Composer yet:

``` bash
composer init
composer require squizlabs/php_codesniffer:"^3.9" --dev
composer require wp-coding-standards/wpcs:"^3.1" --dev
composer require dealerdirect/phpcodesniffer-composer-installer:"^1.0" --dev
```

Verify installation:

``` bash
vendor/bin/phpcs -i
```

You should see **WordPress** listed in the installed standards.

------------------------------------------------------------------------

### Node / JS

Install all JavaScript build dependencies:

``` bash
npm install
```

Or if starting clean:

``` bash
npm init -y
npm install gulp gulp-clean-css gulp-concat gulp-sourcemaps gulp-terser del rollup @rollup/plugin-terser --save-dev
```

------------------------------------------------------------------------

## 4. 🔧 Update Composer Autoloading

Edit the `autoload` section in `composer.json`:

``` json
"autoload": {
  "psr-4": {
    "TMCG\": "src/"
  }
}
```

Then rebuild:

``` bash
composer dump-autoload
```

------------------------------------------------------------------------

## 5. 🧪 Run Build Commands

Once dependencies are installed, test the build pipeline:

``` bash
npm run build
```

Or, for development:

``` bash
npm run watch
```

Gulp handles CSS, Rollup bundles JS, and output is written to `dist/`.

------------------------------------------------------------------------

## 6. 🧹 Linting and Code Standards

Run PHPCS:

``` bash
vendor/bin/phpcs --standard=phpcs.xml src
```

Auto-fix errors:

``` bash
vendor/bin/phpcbf --standard=phpcs.xml src
```

If using GitHub Actions, verify the workflow file:

    .github/workflows/phpcs.yml
