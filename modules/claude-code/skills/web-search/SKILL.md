---
name: web-search
description: Web search using Brave Search API. Use when Claude needs to perform web searches, look up current information, find documentation, or retrieve up-to-date data from the internet. This skill provides a privacy-first alternative to built-in web search capabilities.
---

# Web Search

## Quick Start

Perform a basic web search:

```bash
curl -s "https://api.search.brave.com/res/v1/web/search?q=YOUR_QUERY&count=10" \
  -H "X-Subscription-Token: $BRAVE_SEARCH_API_KEY"
```

The API key should be stored in the `BRAVE_SEARCH_API_KEY` environment variable.

## API Endpoint

**Base URL**: `https://api.search.brave.com/res/v1/web/search`

**Authentication**: via `X-Subscription-Token` header containing your API key

## Query Parameters

| Parameter | Required | Type | Description |
|-----------|----------|------|-------------|
| `q` | Yes | string | Search query string |
| `count` | No | integer | Max results per page (1-20, default 20) |
| `offset` | No | integer | Starting position for pagination (0-based, max 9) |
| `country` | No | string | 2-character country code (e.g., US, DE, CN) |
| `search_lang` | No | string | Filter results by content language (e.g., en, zh, ja) |
| `ui_lang` | No | string | Preferred language for response metadata |
| `freshness` | No | string | Time filter: `pd` (24h), `pw` (week), `pm` (month), `py` (year), or custom range like `2024-01-01to2024-12-31` |
| `safesearch` | No | string | Adult content filtering: `off`, `moderate` (default), `strict` |
| `extra_snippets` | No | boolean | If `true`, includes additional excerpts per result |

## Response Structure

```json
{
  "web": {
    "results": [
      {
        "title": "Result Title",
        "url": "https://example.com",
        "description": "Main snippet/description",
        "extra_snippets": ["Additional excerpt 1", "Additional excerpt 2"]
      }
    ]
  },
  "query": {
    "original": "your search query",
    "more_results_available": true
  }
}
```

## Common Patterns

### Search with recent results only

```bash
curl -s "https://api.search.brave.com/res/v1/web/search?q=latest+news&freshness=pw&count=10" \
  -H "X-Subscription-Token: $BRAVE_SEARCH_API_KEY"
```

### Country-specific search

```bash
curl -s "https://api.search.brave.com/res/v1/web/search?q=python+tutorial&country=US&search_lang=en" \
  -H "X-Subscription-Token: $BRAVE_SEARCH_API_KEY"
```

### Pagination

```bash
# First page
curl -s "https://api.search.brave.com/res/v1/web/search?q=open+source&count=20&offset=0" \
  -H "X-Subscription-Token: $BRAVE_SEARCH_API_KEY"

# Second page (only if more_results_available was true)
curl -s "https://api.search.brave.com/res/v1/web/search?q=open+source&count=20&offset=1" \
  -H "X-Subscription-Token: $BRAVE_SEARCH_API_KEY"
```

### Extra context with snippets

```bash
curl -s "https://api.search.brave.com/res/v1/web/search?q=quantum+computing&extra_snippets=true" \
  -H "X-Subscription-Token: $BRAVE_SEARCH_API_KEY"
```

## Best Practices

1. Check `query.more_results_available` before making additional pagination requests
2. Use `freshness` parameter when you need recent information
3. Set `count` appropriately - smaller values reduce latency and cost
4. Use `extra_snippets=true` when you need more context about each result
5. URL-encode queries with spaces: replace spaces with `+` or `%20`

## Error Handling

- **401 Unauthorized**: Invalid or missing API key
- **429 Too Many Requests**: Rate limit exceeded
- **400 Bad Request**: Invalid query parameters

When errors occur, provide clear feedback about what went wrong and how to fix it.

## Formatting Results

When presenting search results to users, format them as:

```
## [Title](URL)

[description]

[extra_snippets if available]
```

Include the full URL so users can access the source directly.
