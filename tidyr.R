df1 <- data.frame(Firstname = c('John', 'Jeff',  'Ronald', 'Jennifer', 'Jessica'),
   Lastname = c('Novak', 'Barr', 'Lum',   'Forbis', 'Connor'),
   Birthdate = c('15/05/1980', '08/05/1990', '24/07/1988', '19/11/2000', '31/12/1997'))

print(df1)

#a column contains two or more variables. In the demo data set, 
#the Birthday column contains the variable Date, Month, and Year. 
#If we need to work with these three as a separate variable then we can use the separate() function. 
sept <- separate(data = df1,
                 col  = Birthdate,  
                 into = c('Date', 'Month', 'Year'),
                 sep = '/') 
print(sept)

#The unite() function combines multiple columns into a single column. 
#It is the inverse of the separate() function. 
#combine the variable 'Firstname' and 'Lastname' in Name column then we can use unite() function.
unt <- unite(data = df1, 
             col  = Name,
             Firstname, 
             Lastname, 
             sep  = ' ') 
print(unt)

#pivot_wider() function is used when an observation is scattered across several rows.
df2 <- data.frame(Week = c('Week1', 'Week1',  'Week2', 'Week2', 'Week3', 'Week3', 'Week4', 'Week4'),
 Assignment = c('Assignment1', 'Assignment2', 'Assignment1', 'Assignment2', 'Assignment1', 'Assignment2', 'Assignment1', 'Assignment2'),
 Completed = c(3, 5, 4, 3, 5, 4, 3, 5))

print(df2)

pivot_wider(data = df2, 
            id_cols = Week,
            names_from = Assignment, 
            values_from = Completed)

# an observation is given per 'Week' and 'Assignment'. 
#If we want the 'Assignment to appear as column headers, 
#so we can use pivot_wider() function from the tidyr package to 
#transform this data.

#The Pivot_longer Function - need to pivot columns together to create a single column
#with many rows in a case when our data is in a wide format. 
#see that the subject across multiple variables, which is not usually 
#what we want in our tables. In order to get the data in the correct 
#format, we will need to transform those columns into a new pair of variables.

df3 <- data.frame(Student = c('John', 'Jeff', 'Ronald', 'Jennifer', 'Jessica'),
    Maths = c(79, 64, 86, 92, 50),
    Physics = c(62, 45, 94, 83, 65),
    Chemistry = c(99, 61, 87, 91, 80))

print(df3)
pivot_longer(data =  df3, 
             cols = -Student, 
             names_to = "Subject", 
             values_to = "Marks")