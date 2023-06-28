CREATE INDEX IF NOT EXISTS o_p_idx ON order_product (product_id, order_id);
CREATE INDEX IF NOT EXISTS oid_idx ON orders (id);