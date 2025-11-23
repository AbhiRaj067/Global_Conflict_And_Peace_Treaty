# Global Conflict and Peace Treaty Database

A comprehensive relational SQL database for modeling major global conflicts and the peace treaties that resolved them.

## Overview

This project organizes complex information about worldwide conflicts and peace treaties, including details about countries, leaders, organizations, venues, agreement terms, and signatory roles. It enables powerful historical analysis and supports research, education, and analytics.

## Features

- Tracks countries, conflicts, treaties, organizations, venues, and leaders.
- Models many-to-many relationships between countries and treaties (signatory, mediator, observer).
- Captures detailed treaty clauses and meta-data.
- Enables advanced SQL analysis: historical patterns, treaty effectiveness, signatory statistics.

## How to Use

1. **Setup:**  
   - Run `schema.sql` to create all database tables and relationships.
   - (Optional) Use `sample_data.sql` to load example events, treaties, and participants.

2. **Analysis:**  
   - Use sample queries in `queries.sql` to explore data:  
     - List treaties by conflict/era/country  
     - Count signatories  
     - Examine agreement terms and diplomatic outcomes

## Example Use Cases

- Academic or geopolitical research
- Educational timelines and data-driven history
- Policy analysis and conflict resolution statistics

## Project Structure

- `schema.sql`: Database schema (tables and relationships)
- `sample_data.sql`: Example countries, conflicts, treaties, leaders, etc.
- `queries.sql`: Useful starter analytical queries
- `README.md`: Documentation (this file)

## Author

Abhishek Raj

---

Feel free to open an issue or contact me for collaboration or suggestions.

