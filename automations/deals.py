# coding: utf-8

import requests

from rich.console import Console
from rich.table import Column, Table

console = Console()


WILLYS_URL = "https://www.willys.se/search/campaigns/offline?avoidCache=1591788640613&page=0&q=2848&size=30&type=PERSONAL_GENERAL"

data = requests.get(WILLYS_URL).json()

data["results"]

table = Table(show_header=True, header_style="bold")

table.add_column("Name")
table.add_column("Amount", justify="right")
table.add_column("Price", justify="right")
table.add_column("Savings", justify="right")

for x in data["results"]:
    promo = x.get("potentialPromotions", [])
    if promo:
        promo = promo[0]
    else:
        promo = None

    price = None
    if x["price"] is not None and x["priceUnit"] is not None:
        price = x["price"] + " " + x["priceUnit"]

    savings = None
    if promo:
        price = promo["cartLabel"].replace("Välj & blanda!", "")
        if promo["savePrice"] is not None:
            savings = promo["savePrice"].replace("Spara ", "").replace(":00", "")

    table.add_row(x["name"], x.get("displayVolume"), price, savings)

console.print(table)
