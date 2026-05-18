-- 30D CME/Deribit basis rates for dashboard FR Comparison tab
-- Full refresh: use as-is (30 day window)
-- Incremental: replace "INTERVAL 32 DAY" with "INTERVAL 3 DAY"
--   and "INTERVAL 30 DAY" with "INTERVAL 2 DAY"
WITH raw AS (
  SELECT
    CAST(ts AS DATE) AS dt_date,
    UPPER(base_symbol) AS asset,
    LOWER(exchange) AS exchange,
    contract_symbol,
    premium_apr * 100 AS rate
  FROM `pendle-data.boros_analytics.futures_basis_hourly`
  WHERE ts >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 32 DAY)
    AND LOWER(exchange) IN ('cme','deribit')
    AND premium_apr != 0
    AND UPPER(base_symbol) IN ('BTC','ETH','SOL','XAU','XAG','CL','BZ','SP500')
),
with_tenor AS (
  SELECT *,
    CASE
      WHEN REGEXP_CONTAINS(contract_symbol, r'(?i)MAY') THEN 'may'
      WHEN REGEXP_CONTAINS(contract_symbol, r'(?i)JUN') THEN 'jun'
      WHEN REGEXP_CONTAINS(contract_symbol, r'(?i)SEP') THEN 'sep'
      WHEN REGEXP_CONTAINS(contract_symbol, r'K2[6-7]\.') THEN 'may'
      WHEN REGEXP_CONTAINS(contract_symbol, r'M2[6-7]\.') THEN 'jun'
      WHEN REGEXP_CONTAINS(contract_symbol, r'U2[6-7]\.') THEN 'sep'
      ELSE NULL
    END AS tenor
  FROM raw
),
daily AS (
  SELECT
    dt_date, asset,
    CONCAT(exchange, '-', tenor) AS exchange,
    AVG(rate) AS rate
  FROM with_tenor
  WHERE tenor IS NOT NULL
    AND dt_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
  GROUP BY 1,2,3
)
SELECT
  FORMAT_DATE('%Y-%m-%d', dt_date) AS date,
  asset, exchange,
  ROUND(rate, 4) AS rate
FROM daily
ORDER BY asset, exchange, dt_date
