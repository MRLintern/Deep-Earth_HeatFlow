# script to plot the results

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # noqa: F401


# Load data

filename = "../results/temperature_field.bin"

with open(filename, "rb") as f:
    nx, ny, nz = np.fromfile(f, dtype=np.int32, count=3)
    dx = np.fromfile(f, dtype=np.float64, count=1)[0]
    T = np.fromfile(f, dtype=np.float64).reshape((nx, ny, nz), order="F")

print(f"Grid: {nx} x {ny} x {nz}")
print(f"Grid spacing: {dx/1000:.1f} km")


# Coordinates (km)
# Tangential directions

x = np.arange(nz) * dx / 1000.0
y = np.arange(ny) * dx / 1000.0


# Depth: i = nx-1 (mantle, cold) MUST be highest Z

depth = np.arange(nx) * dx / 1000.0   # km

# Build mesh (depth is vertical Z)

X, Y, Z = np.meshgrid(x, y, depth, indexing="ij")


# Temperature anomaly

T_ref = 4000.0
T_anom = T - T_ref

# Reorder temperature to (x, y, depth)

T_plot = np.transpose(T_anom, (2, 1, 0))


# Flatten

Xf = X.ravel()
Yf = Y.ravel()
Zf = Z.ravel()
Tf = T_plot.ravel()


# Manual symmetric normalization

Tmax = np.max(np.abs(Tf))
Tf_norm = Tf / Tmax

print(f"Max |T| = {Tmax:.2f} K")


# Plot

fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection="3d")

sc = ax.scatter(
    Xf, Yf, Zf,
    c=Tf_norm,
    cmap="bwr",   # blue = cold, red = hot
    vmin=-1.0,
    vmax=1.0,
    s=2,
    alpha=0.85
)

ax.set_title(
    "Core–Mantle Boundary Thermal Structure\n"
    "Blue (Cold Mantle), Red (Hot Core) Below"
)

ax.set_xlabel("Tangential distance x (km)")
ax.set_ylabel("Tangential distance y (km)")
ax.set_zlabel("Depth coordinate (km)")

# Camera only (no axis inversion!)

ax.view_init(elev=25, azim=-60)


# Colour bar

cbar = plt.colorbar(sc, ax=ax, shrink=0.7, pad=0.1)
cbar.set_label("Normalized temperature anomaly")

plt.tight_layout()
plt.savefig("CMB_Temperature_Difference.png", dpi=300)
plt.show()
