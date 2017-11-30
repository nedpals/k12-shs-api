# Public API Documentation
>The public API runs on [json-server](https://github.com/typicode/json-server) as a way to create a mock REST API using only JSON. Most of the functions were derived from their repo.

> Since it is a public API, it will be read-only. Meaning you cannot submit or delete entries.

### Get school data
You may get the data of the specific school by passing a `school_id` field to the `/school` node.

```
GET /school/483540 --> Returns data from Genesis Christian Academy
```

### Paginate
Returns a part of db limited to 10 items.
```
GET /schools/1 --> page 1
```
`/schools/:page` is just an alias to the [paginate](#paginate) field. To specify the number of items to be included in a page, use the `_limit` field instead.

### Get schools by region
Returns results with that specific region.
```
GET /schools/region/NCR --> schools in NCR
```

### Filter
To search for other fields other than `school_id`, you may filter results by passing a parameter to the URL.

```
GET /schools?school_id=403932 --> returns the specific school.
GET /schools?region=NCR --> returns schools in the NCR. 
GET /schools?programs=STEM,GAS --> returns schools offering STEM and GAS strands.
GET /schools?programs=STEM&region=Region I --> returns schools in Region I that offers only STEM.
```

### Paginate

Use `_page` and optionally `_limit` to paginate returned data.

In the `Link` header you'll get `first`, `prev`, `next` and `last` links.

**Recommended to avoid your site's speed and performance to degrade due to its size**
```
GET /schools?_page=7
GET /schools?_page=7&_limit=20
```

_10 items are returned by default_

### Sort

Add `_sort` and `_order` (ascending order by default)

```
GET /schools?_sort=views&_order=asc
GET /schools/1/comments?_sort=votes&_order=asc
```

For multiple fields, use the following format:

```
GET /schools?_sort=user,views&_order=desc,asc
```

### Slice

Add `_start` and `_end` or `_limit` (an `X-Total-Count` header is included in the response)

```
GET /schools?_start=20&_end=30
GET /schools/1/comments?_start=20&_end=30
GET /schools/1/comments?_start=20&_limit=10
```

_Works exactly as [Array.slice](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/slice) (i.e. `_start` is inclusive and `_end` exclusive)_

### Full-text search

Add `q`

```
GET /schools?q=Saint Peter's College of Toril
```

### Database

```
GET /db
```