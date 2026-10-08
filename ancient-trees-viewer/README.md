# Ancient Trees Data Viewer

A PHP web app that turns Plymouth's open dataset of ancient trees into a searchable, sortable table.

## What it does

- **Home page** (`index.php`): links to the dataset used and to Plymouth's other open datasets.
- **Data page** (`data.php`): reads the dataset from a CSV file with PHP and builds an HTML table from it, using the first row as the column headings.
- **Search, sorting and pagination**: jQuery DataTables adds a search box, sortable columns, page-by-page navigation and a choice of how many rows to show at once.
- **Shared header and footer**: `header.php` and `footer.php` are included on every page, so the navigation stays the same as you move between pages.

## The data

The dataset comes from Plymouth's open data portal: https://plymouth.thedata.place/dataset/ancient-trees

Each record describes one tree, including its species, location, girth, condition, public access and survey date.

## Running it locally

1. Install PHP 7 or later.
2. Open a terminal in the project folder and run `php -S localhost:8000`.
3. Go to http://localhost:8000/index.php in your browser.

## Project structure

```
index.php      Home page with links to the datasets
data.php       Reads the CSV and renders the table
header.php     Shared header and navigation
footer.php     Shared footer
css/           Styles
js/            Page scripts
resources_...ancient_trees.csv   The dataset
```

## Tech

PHP, HTML, CSS, JavaScript, jQuery, DataTables, Bootstrap

## Credits

The page layout is based on a free template from [HTML Codex](https://htmlcodex.com). The dataset is published on Plymouth's open data portal.
