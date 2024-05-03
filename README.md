# Markr ingestion & processing service

## Supported functionality
### 1. Ingest test results from `POST /import`
- Body is XML. Example:
    ```
    curl -X POST -H 'Content-Type: text/xml+markr' http://localhost:4567/import -d @- 
        <mcq-test-results>
            <mcq-test-result scanned-on="2017-12-04T12:12:10+11:00">
                <first-name>Jane</first-name>
                <last-name>Austen</last-name>
                <student-number>521585128</student-number>
                <test-id>1234</test-id>
                <summary-marks available="20" obtained="13" />
                <answer question="0" marks-available="1" marks-awarded="1">D</answer>
                ...
                <answer question="50" marks-available="1" marks-awarded="1">C</answer>
            </mcq-test-result>
            <mcq-test-result scanned-on="2017-12-04T12:12:10+11:00">
                ...
            </mcq-test-result>
            ...
        </mcq-test-results>
    ```
- Expected content-type is text/xml+markr (rejects others)
- Rejects import if missing any data we expect (ids, scores, etc.), returning a `400`.
- If there is more than one test result for a student (for the same test), we accept the highest grade and the highest available grade. (note: these double-up results could be in separate requests).


### 2. Expose aggregate data at `/results/:test-id/aggregate`
- Provides results as a JSON document with the following fields
    -   `mean` - the mean of the awarded marks
    -   `count` - the number of students who took the test
    -   `p25`, `p50`, `p75` - the 25th percentile, median, and 75th percentile scores
- Note numbers are in (float) percentages of the available marks in the test.
- Example returned data:
    ```
    curl http://localhost:4567/results/1234/aggregate
    {"mean":65.0,"stddev":0.0,"min":65.0,"max":65.0,"p25":65.0,"p50":65.0,"p75":65.0,"count":1}
    ```

## Other notes
- Assumptions:
    - Reject non text/xml+markr content types at /import
    - Reject /import when any test result is missing any data we expect (ids, results, scores, date, etc.).
    - We'll need to calculate scores eventually.
- TODO: Tests
    - Ingest multiple student results for the same test (with a difference in grade and available grade). Test across multiple transations, and more than 2 results.
    - Test import -> aggregate results for known values.
- TODO: How will this handled real-time dashboards?
- TODO: The folder structure isn't the best as I didn't have time to configure the `build_runner` to look for files in the non-default location.
- TODO: if we want to support serving *student* aggregate results we’ll need another box, and we’ll need to update whenever a test with their student-number is updated.