import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import pymc as pm
import arviz_base as azb
import arviz_stats as azs

RANDOM_SEED = 2027
rng = np.random.default_rng(RANDOM_SEED)

print("PyMC:", pm.__version__)
