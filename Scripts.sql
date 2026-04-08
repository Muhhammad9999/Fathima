/*Window functions = functions that calculate a value for each row using a “window” of related rows, without collapsing rows like GROUP BY.

Basic syntax
<function>() OVER (PARTITION BY ... ORDER BY ... [frame])

PARTITION BY: splits data into groups (like group-by, but rows stay).
ORDER BY: orders rows inside each group (needed for ranking/running totals).
Frame (optional): which rows around the current row are included (e.g., last 7 rows)

Basic syntax
<function>() OVER (PARTITION BY ... ORDER BY ... [frame])

 */


-- Common uses (examples)
# Ranking
SELECT *, ROW_NUMBER() OVER (PARTITION BY C_MKTSEGMENT ORDER BY C_ACCTBAL DESC) AS rn
FROM MY_DATABASE.PUBLIC.CUSTOMER_S21;

# Running total
SELECT C_NATIONKEY, C_ACCTBAL,
       SUM(C_ACCTBAL) OVER (PARTITION BY C_NATIONKEY ORDER BY C_CUSTKEY
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_sum
FROM MY_DATABASE.PUBLIC.CUSTOMER_S21;


# Previous/next row (LAG/LEAD)

SELECT C_NATIONKEY, C_CUSTKEY, C_ACCTBAL,
       LAG(C_ACCTBAL) OVER (PARTITION BY C_NATIONKEY ORDER BY C_CUSTKEY) AS prev_bal
FROM MY_DATABASE.PUBLIC.CUSTOMER_S21;