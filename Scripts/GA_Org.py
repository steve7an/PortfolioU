
# coding: utf-8

# # # GA Example

# In[5]:


import numpy

def cal_pop_fitness(equation_inputs, pop):
    # Calculating the fitness value of each solution in the current population.
    # The fitness function caulcuates the sum of products between each input and its corresponding weight.
    fitness = numpy.sum(pop*equation_inputs, axis=1)
    return fitness

def select_mating_pool(pop, fitness, num_parents):
    # Selecting the best individuals in the current generation as parents for producing the offspring of the next generation.
    parents = numpy.empty((num_parents, pop.shape[1]))
    for parent_num in range(num_parents):
        max_fitness_idx = numpy.where(fitness == numpy.max(fitness))
        max_fitness_idx = max_fitness_idx[0][0]
        parents[parent_num, :] = pop[max_fitness_idx, :]
        print("Max fitness idx",max_fitness_idx)
        fitness[max_fitness_idx] = -99999999999
    return parents

def crossover(parents, offspring_size):
    offspring = numpy.empty(offspring_size)
    # The point at which crossover takes place between two parents. Usually it is at the center.
    crossover_point = numpy.uint8(offspring_size[1]/2)

    for k in range(offspring_size[0]):
        # Index of the first parent to mate.
        parent1_idx = k%parents.shape[0]
        # Index of the second parent to mate.
        parent2_idx = (k+1)%parents.shape[0]
        # The new offspring will have its first half of its genes taken from the first parent.
        offspring[k, 0:crossover_point] = parents[parent1_idx, 0:crossover_point]
        # The new offspring will have its second half of its genes taken from the second parent.
        offspring[k, crossover_point:] = parents[parent2_idx, crossover_point:]
    return offspring

def mutation(offspring_crossover):
    # Mutation changes a single gene in each offspring randomly.
    for idx in range(offspring_crossover.shape[0]):
        # The random value to be added to the gene.
        random_value = numpy.random.uniform(-1.0, 1.0, 1)
        offspring_crossover[idx, 4] = offspring_crossover[idx, 4] + random_value
    return offspring_crossover


# In[6]:


# Inputs of the equation.
equation_inputs = [4,-2,3.5,5,-11,-4.7,2,-6,8,5.5]
# Number of the weights we are looking to optimize.
num_weights = 10  ## One individual contains 10 weights

sol_per_pop = 20  ## 10 individuals makes one population
# Defining the population size.

pop_size = (sol_per_pop,num_weights) # The population will have sol_per_pop chromosome where each chromosome has num_weights genes.

print("POP size",pop_size)
#Creating the initial population.

new_population = numpy.random.uniform(low=-4.0, high=4.0, size=pop_size)
#Creating the initial population.
print(new_population)


# In[7]:


#import ga as GA
num_generations = 5

num_parents_mating = 2

for generation in range(num_generations):
    # Measuring the fitness of each chromosome in the population.
    #print(new_population)
    # equation_inputs = [4,-2,3.5,5,-11,-4.7,2,-6,8,5.5]
    fitness = cal_pop_fitness(equation_inputs, new_population)
    #print(1,fitness)
    print("Number generations",num_generations,"current generation",generation)
    print("fitness",fitness)
    #print('population',new_population)
    parents = select_mating_pool(new_population, fitness, num_parents_mating)
    print("current generation",generation,"parents",parents)
    offspring_crossover = crossover(parents, offspring_size=(pop_size[0]-parents.shape[0], num_weights))
    #print(3)
    print(pop_size[0]-parents.shape[0], num_weights)
    print ("crossover",offspring_crossover)
    # Adding some variations to the offsrping using mutation.
    offspring_mutation = mutation(offspring_crossover)
    print("Mutation",offspring_mutation)
    # Creating the new population based on the parents and offspring.
    print("Best result : ", numpy.max(numpy.sum(new_population*equation_inputs, axis=1)))
    new_population[0:parents.shape[0], :] = parents
    #print(offspring_mutation)
    #print(parents.shape[0])
    #print('before asst',new_population)
    new_population[parents.shape[0]:, :] = offspring_mutation
    #print(new_population)
    # The best result in the current iteration.
    print("Best result : ", numpy.max(numpy.sum(new_population*equation_inputs, axis=1)))


# In[8]:



# Getting the best solution after iterating finishing all generations.
#At first, the fitness is calculated for each solution in the final generation.
fitness = cal_pop_fitness(equation_inputs, new_population)

# Then return the index of that solution corresponding to the best fitness.
best_match_idx = numpy.where(fitness == numpy.max(fitness))

print("Best solution : ", new_population[best_match_idx, :])
print("Best solution fitness : ", fitness[best_match_idx])

