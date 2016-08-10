clear all; close all; clc;
purchase_price = 900e3;
down_payment = 180e3;
beginning_principal = purchase_price - down_payment;
real_estate_appr = 1.0985; %percentage
loan_rate = 3.1; %percentage
N = 30;
M = 10; % selling after M years; M <= N
misc_costs_per_year = 7e3;
property_tax_base = .01 * purchase_price;
property_tax_rate_increase = 1.01; %per year
insurance_cost_per_year = 1e3;
r = loan_rate / 12 / 100;
emi = (r * beginning_principal)/(1 - (1 + r)^-(N*12));
closing_cost = 1.06;
profit_percentage = zeros(1, M);
for I = 1:M
    property_tax_Iyears = property_tax_base * (property_tax_rate_increase^I - 1)/(property_tax_rate_increase - 1);
    principal_after_Iyears = beginning_principal * (1 + r)^(I * 12) - emi*((1 + r)^(I * 12) - 1)/(1 + r - 1);
    total_payment = emi * 12 * I;
    total_interest_paid = total_payment - (beginning_principal - principal_after_Iyears);

    sale_price = purchase_price * real_estate_appr^I;
    profit = sale_price * (2 - closing_cost);
    actual_profit = profit - principal_after_Iyears;
    actual_investment = down_payment + total_payment + property_tax_Iyears + misc_costs_per_year * I + insurance_cost_per_year * I;
    profit_percentage(I) = ((actual_profit / actual_investment) ^ (1/I) - 1) * 100;
end
plot(1:M, profit_percentage, '-bx','LineWidth',2,...
    'MarkerSize',7,...
    'MarkerEdgeColor','r');
ylabel('profit in percentage');
xlabel('time in years');
grid on;
