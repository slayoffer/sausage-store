CREATE TABLE IF NOT EXISTS order_product
(
    quantity INTEGER NOT NULL,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS orders
(
    id BIGINT GENERATED BY DEFAULT AS IDENTITY,
    date_created DATE,
    status VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS product
(
    id BIGINT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    picture_url VARCHAR(255),
    price DOUBLE PRECISION
);