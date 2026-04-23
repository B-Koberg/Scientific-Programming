import argparse

import matplotlib.pyplot as plt
import numpy as np


def plot_distribution(input_file: str, output_image: str | None = None) -> None:
	data = np.loadtxt(input_file, comments="#")

	if data.ndim == 1:
		data = data.reshape(1, -1)

	values = data[:, 0].astype(int)
	counts = data[:, 1].astype(int)
	rel_freq = data[:, 2]

	plt.figure(figsize=(9, 5))
	plt.bar(values, counts, width=0.8, edgecolor="black")
	plt.title("Verteilung der Zufallszahlen")
	plt.xlabel("Wert")
	plt.ylabel("Haeufigkeit")
	plt.xticks(values)
	plt.grid(axis="y", linestyle="--", alpha=0.4)
	plt.tight_layout()

	if output_image:
		plt.savefig(output_image, dpi=150)
		print(f"Plot gespeichert als: {output_image}")
	else:
		plt.show()

	print("Relative Haeufigkeiten:")
	for v, rf in zip(values, rel_freq):
		print(f"{v:3d}: {rf:.4f}")


def main() -> None:
	parser = argparse.ArgumentParser(
		description="Liest die Fortran-Ausgabe und stellt die Verteilung dar."
	)
	parser.add_argument(
		"-i",
		"--input",
		default="tsunami_output.txt",
		help="Pfad zur Eingabedatei (Standard: tsunami_output.txt)",
	)
	parser.add_argument(
		"-o",
		"--output",
		default=None,
		help="Optional: Dateiname fuer den Plot (z.B. verteilung.png)",
	)

	args = parser.parse_args()
	plot_distribution(args.input, args.output)


if __name__ == "__main__":
	main()
