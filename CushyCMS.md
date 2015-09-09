# Basics to CushyCMS

### Overview

Cushy will intelligently edit any element with a css class of cushycms on it.

```html
<h1 class='cushycms' title='My Heading'>This will become editable</h1>
<div class='cushycms' title='Main Content'>
  <p>More editable stuff here...</p>
</div>
<p>I'm not editable</p>
<img class='cushycms' src='foo.jpg' alt='Im an editable image!' />
```

You can also assign a cushycms class even if there is another class for that element.
