package dev.daytracker.model;

import org.slf4j.Logger;

import java.time.LocalDate;
import java.util.Random;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Utility that can randomly generate model data for testing.  Random data is generated using a seed, which
 * can be printed with the printSeed method and replayed by calling the replaySeed method before any other methods are
 * called on TestData.  All test methods use the global RANDOM object for seed data generation, so they'll generate
 * the same data with the same seed.  Replay is not stable if test data is generated in different threads.
 */
public final class TestData {
  private static final Logger log = getLogger(TestData.class);

  private static final AtomicLong SEED = new AtomicLong(System.currentTimeMillis());
  private static final Random RANDOM = new Random(SEED.get());
  private static final AtomicBoolean RANDOM_USED = new AtomicBoolean(false);

  private static final char[] LETTERS = new char[]{
      'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ',
      'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  };

  private TestData() {}

  /**
   * Sets the seed on the RANDOM object that's used to generate all test data.  Call this method before calling
   * any other methods on this class to replay a test with the same data.  Throws an IllegalStateException if
   * test data has already been generated.
   *
   * @param seed Seed to replay
   */
  public static void replaySeed(long seed) {
    if (RANDOM_USED.get()) {
      throw new IllegalStateException("Cannot replay tests with a seed after random data has been generated.");
    }

    SEED.set(seed);
    RANDOM.setSeed(seed);
  }

  /**
   * Prints the test data seed.
   */
  public static void printSeed() {
    log.info("Test data seed: {}", SEED);
  }

  /**
   * Generates a random activity with no id.
   *
   * @return Random activity.
   */
  public static Activity randomActivity() {
    RANDOM_USED.set(true);

    return Activity.newBuilder()
        .withText(randomString(128))
        .withDate(LocalDate.now().minusDays(RANDOM.nextInt(180)))
        .build();
  }

  /**
   * Returns a random ascii string with the given length.
   *
   * @param length Length of the generated string
   * @return Random string with the given length
   */
  private static String randomString(int length) {
    return IntStream.range(0, length)
        .mapToObj(i -> String.valueOf(randomElement(LETTERS)))
        .collect(Collectors.joining());
  }

  /**
   * Returns a randomly selected element out of the given values.
   * @param values List of possible values
   * @return Random element.
   */
  private static char randomElement(char[] values) {
    return values[RANDOM.nextInt(values.length)];
  }

  /**
   * Returns a randomly selected element out of the given values.
   * @param values List of possible values
   * @return Random element.
   */
  private static <T> T randomElement(T[] values) {
    return values[RANDOM.nextInt(values.length)];
  }
}
