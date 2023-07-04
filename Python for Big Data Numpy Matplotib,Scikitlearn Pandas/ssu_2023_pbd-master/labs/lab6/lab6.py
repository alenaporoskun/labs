import pandas as pd


def main():

    print_header("Лабораторна 6 Pandas")
    orders = pd.read_csv('data/orders.csv')
    print("orders = pd.read_csv('data/orders.csv')")
    print("- orders: \n", orders, "\n")

    customers = pd.read_csv('data/customers.csv', index_col='id')
    # customers = pd.read_csv('data/customers.csv')
    print("customers = pd.read_csv('data/customers.csv')")
    print("- customers: \n", customers, "\n")


    print_header("Task \n Використовуючи дані та код з лекції знайти \n"
                 " перші 4 міста, які найбільш збиткові у 2017 році для даних: \n * orders.csv, \n * customers.csv")

    print("# Для початку відфільтруємо замовлення з 2017 року:")
    orders_2017 = orders.query("order_date >= '2017-01-01' & order_date <= '2017-12-31'")
    print("orders_2017 = orders.query(\"order_date >= '2017-01-01' & order_date <= '2017-12-31'\")")
    print("- orders_2017.head():\n", orders_2017.head(), "\n")


    print("# Місто – це атрибут користувачів, а не замовлень. Тобто, додамо інформацію про користувачів:")
    with_customers_2017 = pd.merge(customers, orders_2017, how='inner', left_index=True,
                                   right_on='customer_id')
    print('''with_customers_2017 = pd.merge(customers, orders_2017, how='inner', left_index=True,
                                             right_on='customer_id')''')
    print("- with_customers_2017.head(3):\n", with_customers_2017.head(3), "\n")


    print("# Сгрупуємо датафрейм по містах, і порахуємо виторг:")
    grouped_2017 = with_customers_2017.groupby('city')['sales'].sum()
    print("grouped_2017 = with_customers_2017.groupby('city')['sales'].sum()")
    print("- grouped_2017.head():\n", grouped_2017.head(), "\n")

    print("# Відсортуємо за збільшенням продажу та залишимо TOP-4:")
    top4 = grouped_2017.sort_values(ascending=True).head(4)
    print("top4 = grouped_2017.sort_values(ascending=True).head(4)")
    print("- top4:\n", top4, "\n")
    # print("- top4.index:\n", top4.index[0:4], "\n")
    answer = []
    for i in range(4):
        answer.append(top4.index[i])

    print('''Додамо до списку назви міст:
answer = []
for i in range(4):
    answer.append(top4.index[i])''')
    print("- answer:\n", answer)
    print_header("Отже, ми знайшли перші 4 міста, які найбільш збиткові у 2017 році.")


def print_header(msg):
    line = '=' * (len(msg) + 2)
    print(f'\n{line}')
    print(f' {msg} ')
    print(f'{line}')


if __name__ == '__main__':
    main()
