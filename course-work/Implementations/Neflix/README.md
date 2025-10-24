# Netflix Data Platform Coursework

**Student:** Mustafa Buhov

**Faculty Number:** 2301322033

**Project Theme:** Netflix

---

## Project Overview
- Conceptual, logical and data warehouse blueprints for modelling a Netflix-like streaming service.
- Physical SQL Server implementation that builds the transactional schema, populates it with sample data, and delivers required programmability objects (stored procedures, functions, triggers).
- Business intelligence artefacts: star-schema warehouse design and a folder for Power BI/Tableau visualisations built on top of the implemented dataset.

## Repository Structure
- `netflix_init_apply_script.sql` – end-to-end SQL Server script that creates and seeds the OLTP database together with required programmable objects.
- `Diagrams/`
  - `netflix_chens_diagram.drawio` – conceptual/Chen ER model.
  - `netflix_crows_foot_diagram.drawio` – logical/Crow's Foot ER model with 8+ entities, 30+ attributes, and M:N relationships captured via bridge tables.
  - `netflix_data_warehouse_diagram.drawio` – star-schema layout (UML notation) containing three fact tables and six dimension tables.
- `Vizualizations/` – placeholder for Power BI (or Tableau/Looker Studio) report files with at least four visuals fed by the warehouse.

## Transactional Database Implementation
The OLTP layer focuses on core streaming workflows: subscription management, multi-profile accounts, catalogue metadata, and engagement (ratings, watchlists, comments).

### Schema Highlights
- **Tables (11):** `Genre`, `Movie`, `Actor`, `MovieActor`, `Subscription`, `[User]`, `UserProfile`, `Rating`, `Watchlist`, `Comment`, plus supporting bridge tables.
- **Relationships:**
  - `MovieActor` enables the M:N association between `Movie` and `Actor`.
  - `Watchlist` maintains M:N links between `UserProfile` and `Movie`.
  - `Rating` and `Comment` capture user-generated feedback tied to both profiles and titles.
- **Constraints:** Primary keys on all tables, foreign keys enforcing referential integrity, domain checks (e.g., enumerated genres, rating range 1–10), and `UNIQUE` constraints for usernames/profile names.

### Programmability Objects
- **Stored Procedures**
  1. `GetMoviesByGenre` – returns the filmography for a selected genre ordered by release date (descending).
  2. `GetUserWatchlist` – aggregates all titles saved across a user's profiles with metadata for reporting.
- **Scalar Functions**
  1. `dbo.F_GetMovieDurationByMovieID` – converts runtime minutes into a human-readable `H hours M minutes` format.
  2. `dbo.F_GetUserFullName` – derives a person's name by reusing the `Actor` catalogue (demonstrates cross-entity logic for coursework requirements).
- **Triggers**
  1. `trg_UpdateRatingDate` – stamps `RatingDate` with the current timestamp on insert, ensuring recency is sourced from the database engine.
  2. `trg_PreventMovieDeletion` – blocks deletion of movies that already have ratings to preserve analytic history.

### Sample Usage
```sql
-- List all Action movies
EXEC GetMoviesByGenre @GenreID = 1;

-- Fetch watchlist items for user id 1
EXEC GetUserWatchlist @UserID = 1;

-- Show formatted runtime for movie id 3
SELECT dbo.F_GetMovieDurationByMovieID(3);
```

## Data Warehouse Design
The warehouse targets engagement analytics and catalogue performance. The diagram defines:
- **Fact Tables:** `Fac Rating`, `Fac Watchlist`, `Fac Comment` (each tracks a grain of user interaction and links to common dimensions).
- **Dimension Tables:** `DIM User`, `DIM UserProfile`, `DIM Movie`, `DIM Genre`, `DIM Date`, plus auxiliary dimensions captured in the diagram (e.g., subscription or platform metadata if expanded).
- Conformed keys (e.g., `DateID`, `MovieID`, `ProfileID`) enable cross-fact reporting for time-series, title performance, and customer segmentation.

> Use the Draw.io files directly (open them in diagrams.net or VS Code Draw.io extension) to inspect attributes, surrogate keys, and defined hierarchies.

## Business Intelligence Layer
- Build a Power BI / Tableau / Looker Studio report by connecting to the warehouse schema (after ETL).
- Recommended visuals (minimum 4): rating distribution by genre, watchlist growth trend, top-commented titles, subscription mix by engagement.
- Store `.pbix`, `.twbx`, or equivalent output files in `Vizualizations/`.

## Setup & Execution
1. **Prerequisites**
   - Microsoft SQL Server (2019+) or Azure SQL Database.
   - Client tooling: Azure Data Studio, SQL Server Management Studio, or `sqlcmd`.
2. **Database Deployment**
   - Open `netflix_init_apply_script.sql` in your SQL client.
   - Execute the script end-to-end (`GO` batches are pre-configured).
   - Verify creation of the `Netflix` database and row counts in each table.
3. **Post-Deployment Checks**
   - Run the sample procedure/function calls above to confirm programmability objects are compiled.
   - Test trigger behaviour by inserting a rating or attempting to delete a rated movie.
4. **Data Warehouse Population**
   - Design ETL processes (e.g., SQL Agent job, SSIS, ADF pipeline) to move curated data into the fact/dimension tables described in the Draw.io diagram.
   - Maintain surrogate keys and slowly changing dimension strategy as needed.
5. **Analytics & Reporting**
   - Connect Power BI/Tableau to the warehouse schema.
   - Publish at least four visuals and export/post the report file into `Vizualizations/`.

