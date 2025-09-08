SELECT
  acct_id,
  cust_birth_date,
  cust_age,
  DATE_DIFF(CURRENT_DATE(), cust_birth_date, YEAR) AS calc_age,
  cust_age - DATE_DIFF(CURRENT_DATE(), cust_birth_date, YEAR) AS diff
FROM `centering-oxide-345205.prod_carplus_adw.customers`
LIMIT 50;